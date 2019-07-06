# frozen_string_literal: true

class Thing < ApplicationRecord
  include Uploader::Attachment.new(:file)

  attribute :vote, default: nil
  attribute :bookmark, default: nil

  belongs_to :sub
  belongs_to :user
  belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id", optional: true
  belongs_to :deleted_by, class_name: "User", foreign_key: "deleted_by_id", optional: true
  belongs_to :post, class_name: "Thing", counter_cache: :comments_count, optional: true
  belongs_to :comment, class_name: "Thing", counter_cache: :comments_count, optional: true
  has_one :topic, foreign_key: "post_id"
  has_many :comments, foreign_key: "post_id", class_name: "Thing"
  has_many :bookmarks
  has_many :votes
  has_many :reports
  has_one :notification
  has_many :logs, as: :loggable
  has_one :mod_queue

  enum thing_type: { post: 1, comment: 2 }
  enum content_type: { text: 1, link: 2, media: 3 }

  scope :thing_type, ->(type) { where(thing_type: type) if type.present? }
  scope :not_deleted, -> { where(deleted: false) }

  scope :sort_records_by, -> (sort) do
    if sort.present?
      if sort == :created_at
        order(id: :desc)
      else
        order("#{sort}_score" => :desc, id: :desc)
      end
    end
  end

  scope :records_after, ->(record, sort) do
    if record.present?
      if sort == :created_at
        where("id < ?", record.id)
      else
        where("(#{sort}_score, id) < (?, ?)", record["#{sort}_score"], record.id)
      end
    end
  end

  scope :records_after_date, ->(date) { where("created_at > ?", date) if date.present? }

  before_create :normalize_url_on_create
  before_create :set_edited_at_on_create
  before_create :set_approval_attributes_on_create
  before_create :set_file_processing_attributes_on_file_cache
  before_update :update_edited_at_on_edit
  before_update :reset_file_processing_attributes_on_file_store
  before_update :reset_approval_attributes_on_edit
  before_update :reset_approval_attributes_on_deletion
  before_update :reset_deletion_attributes_on_approving
  after_create :create_mod_queue_on_create
  after_create :increment_rate_limits_on_create
  after_create :create_topic_on_create
  after_create :insert_to_topic_on_create
  after_create :create_up_vote_on_create
  after_create :create_notification_on_create
  after_update :update_post_counter_cache_on_approving_or_deletion
  after_update :update_comment_counter_cache_on_approving_or_deletion
  after_update :create_mod_queue_on_edit
  after_update :delete_mod_queue_on_approving_or_deletion
  after_update :delete_reports_on_approving_or_deletion
  after_update :update_comment_in_topic_on_approving_or_deletion
  before_save :text_to_html_on_create_or_edit

  with_options if: ->(r) { r.post? } do
    validates :title, presence: true, length: { maximum: 350 }
  end

  with_options if: ->(r) { r.post? && r.errors.blank? } do
    validates :title, rate_limit: { key: ->(r) { r.thing_type }, sub: ->(r) { r.sub } }, on: :create
  end

  with_options if: ->(r) { r.comment? && r.errors.blank? } do
    validates :text, rate_limit: { key: ->(r) { r.thing_type }, sub: ->(r) { r.sub } }, on: :create
  end

  with_options if: ->(r) { r.text? } do
    validates :text, presence: true, length: { maximum: 10_000 }
  end

  with_options if: ->(r) { r.link? } do
    validates :url, presence: true, length: { maximum: 2048 }
  end

  with_options if: ->(r) { r.link? && r.errors.blank? } do
    validate :validate_domain_not_blacklisted, on: :create
  end

  with_options if: ->(r) { r.media? } do
    validates :file, presence: true
  end

  validates :deletion_reason, allow_blank: true, length: { maximum: 5_000 }
  validates :tag, allow_blank: true, length: { maximum: 30 }

  def scores_stale?
    updated_at < 20.minutes.ago || (up_votes_count < 20 && down_votes_count < 20)
  end

  def edited?
    created_at != edited_at
  end

  def youtube?
    return false unless link?

    @youtube ||= %w(youtube.com www.youtube.com youtu.be www.youtu.be).include?(URI(url).host)
  end

  def youtube_id
    return unless youtube?

    @youtube_id ||= url.to_s.gsub(/(https?:\/\/)?(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\?\S+)?/) do
      Regexp.last_match(4).to_s
    end
  end

  def image?
    return false unless media?

    file[:original].type == "image"
  end

  def video?
    return false unless media?

    file[:original].type == "video"
  end

  def gif?
    return false unless media?

    file[:original].type == "gif"
  end

  def cut_text_preview?
    return false unless text?

    if Current.variant.desktop?
      text.length > 800
    elsif Current.variant.mobile?
      text.length > 500
    end
  end

  def cut_image_preview?
    return false unless image?

    _, height = image_content_dimensions
    height > 550
  end

  def image_content_dimensions
    return false unless image?

    variant = Current.variant.first

    if file[variant].height > 550 && !Current.variant.mobile?
      coefficient_by_max_height = 550 / file[variant].height.to_f
      width_calculated_with_coefficient_by_max_height = (file[variant].width * coefficient_by_max_height).round

      if width_calculated_with_coefficient_by_max_height < 350
        coefficient_by_min_width = 350 / file[variant].width.to_f

        [(file[variant].width * coefficient_by_min_width).round, (file[variant].height * coefficient_by_min_width).round]
      else
        [width_calculated_with_coefficient_by_max_height, (file[variant].height * coefficient_by_max_height).round]
      end
    else
      [file[variant].width, file[variant].height]
    end
  end

  def reset_approval_attributes
    assign_attributes(
      approved: false,
      approved_by: nil,
      approved_at: nil
    )
  end

  def reset_deletion_attributes
    assign_attributes(
      deleted: false,
      deleted_by: nil,
      deleted_at: nil,
      deletion_reason: nil
    )
  end

  def title=(value)
    super(value.squish)
  end

  def tag=(value)
    super(value&.squish)
  end

  def text=(value)
    super(value.strip)
  end

  def deletion_reason=(value)
    super(value&.squish)
  end

  def presenter
    @presenter ||= ThingPresenter.new(self)
  end

  private

  def validate_domain_not_blacklisted
    uri = Addressable::URI.parse(url).normalize

    if uri.present? && uri.host.present? && uri.scheme.in?(%w(http https))
      domain = uri.host.split(".").last(2).join(".")

      if BlacklistedDomain.where(sub: [sub, nil]).where("lower(domain) = ?", domain.downcase).exists?
        errors.add(domain, :blacklisted_domain)
      end
    else
      errors.add(:url, :invalid)
    end
  rescue StandardError
    errors.add(:url, :invalid)
  end

  def normalize_url_on_create
    return unless link?

    self.url = Addressable::URI.parse(self.url).normalize.to_s
  end

  def set_edited_at_on_create
    self.edited_at = created_at
  end

  def set_approval_attributes_on_create
    if user.staff? || user.sub_moderator?(sub) || user.sub_contributor?(sub)
      assign_attributes(
        approved: true,
        approved_by: User.auto_moderator,
        approved_at: created_at
      )
    end
  end

  def set_file_processing_attributes_on_file_cache
    return unless media?
    return unless file_data_changed? && file_attacher.cached?

    assign_attributes(
      deleted: true,
      deleted_by: User.auto_moderator,
      deleted_at: Time.current
    )
  end

  def update_edited_at_on_edit
    return if !text? || !text_changed?

    self.edited_at = Time.current
  end

  def reset_file_processing_attributes_on_file_store
    return unless media?
    return unless file_data_changed? && file_attacher.stored?

    reset_deletion_attributes
  end

  def reset_approval_attributes_on_edit
    return unless edited_at_changed?
    return if user.staff? || user.sub_moderator?(sub) || user.sub_contributor?(sub)

    reset_approval_attributes
  end

  def reset_approval_attributes_on_deletion
    return unless deleted_changed?(from: false, to: true)

    reset_approval_attributes
  end

  def reset_deletion_attributes_on_approving
    return unless approved_changed?(from: false, to: true)

    reset_deletion_attributes
  end

  def create_mod_queue_on_create
    return if approved?

    create_mod_queue!(queue_type: :not_approved)
  end

  def increment_rate_limits_on_create
    RateLimit.hit(thing_type, sub)
  end

  def create_topic_on_create
    return unless post?

    create_topic!
  end

  def insert_to_topic_on_create
    return unless comment?

    json = {
      id: id,
      thing_id: replied_to.id,
      deleted: false,
      scores: {
        best: best_score,
        top: top_score,
        controversy: controversy_score,
        created_at: created_at.to_i
      }
    }.to_json

    ActiveRecord::Base.connection.execute(
      "UPDATE topics SET branch = jsonb_set(branch, '{#{id}}', '#{json}', true), updated_at = '#{Time.current.strftime('%Y-%m-%d %H:%M:%S.%N')}' WHERE post_id = #{post_id};"
    )
  end

  def create_up_vote_on_create
    votes.create!(vote_type: :up, user: user)
  end

  def create_notification_on_create
    return unless send_notification?

    create_notification(user: replied_to.user)
  end

  def send_notification?
    comment? && !replied_to_yourself? && replied_to.receive_notifications?
  end

  def replied_to
    return false unless comment?

    comment.presence || post
  end

  def replied_to_yourself?
    return false unless comment?

    user_id == replied_to.user_id
  end

  def create_mod_queue_on_edit
    return unless edited_at_previous_change.present?
    return if approved?

    create_mod_queue!(queue_type: :not_approved)
  end

  def delete_mod_queue_on_approving_or_deletion
    previous_approved = approved_previous_change&.compact
    previous_deleted = deleted_previous_change&.compact

    if previous_approved == [false, true] || previous_deleted == [false, true]
      mod_queue&.destroy!
    end
  end

  def delete_reports_on_approving_or_deletion
    previous_approved = approved_previous_change&.compact
    previous_deleted = deleted_previous_change&.compact

    if previous_approved == [false, true] || previous_deleted == [false, true]
      reports.destroy_all
    end
  end

  def update_post_counter_cache_on_approving_or_deletion
    return unless comment?

    previous = deleted_previous_change&.compact

    if previous == [false, true]
      post.decrement!(:comments_count)
    elsif previous == [true, false]
      post.increment!(:comments_count)
    end
  end

  def update_comment_counter_cache_on_approving_or_deletion
    return unless comment?
    return if comment.blank?

    previous = deleted_previous_change&.compact

    if previous == [false, true]
      comment.decrement!(:comments_count)
    elsif previous == [true, false]
      comment.increment!(:comments_count)
    end
  end

  def update_comment_in_topic_on_approving_or_deletion
    return unless comment?
    return unless deleted_previously_changed?

    ActiveRecord::Base.connection.execute(
      "UPDATE topics SET branch = jsonb_set(branch, '{#{id}, deleted}', '#{deleted}', false), updated_at = '#{Time.current.strftime('%Y-%m-%d %H:%M:%S.%N')}' WHERE post_id = #{post_id};"
    )
  end

  def text_to_html_on_create_or_edit
    return unless text? || text_changed?

    markdown = Redcarpet::Markdown.new(
      MarkdownRenderer.new(
        escape_html: true,
        hard_wrap: true,
        no_images: true,
        link_attributes: { rel: "nofollow", target: "_blank" },
        space_after_headers: true,
        fenced_code_blocks: true,
        safe_links_only: true
      ),
      autolink: true,
      tables: true,
      superscript: true,
      strikethrough: true,
      disable_indented_code_blocks: true
    )

    self.text_html = markdown.render(text)
  end
end
