# frozen_string_literal: true

class Thing < ApplicationRecord
  include Editable
  include Approvable
  include Deletable
  include Notifiable
  include Reportable
  include Uploader::Attachment.new(:file)

  attribute :vote, default: nil
  attribute :bookmark, default: nil

  belongs_to :sub
  belongs_to :user
  belongs_to :post, class_name: "Thing", counter_cache: :comments_count, optional: true
  belongs_to :comment, class_name: "Thing", counter_cache: :comments_count, optional: true
  has_one :topic, foreign_key: "post_id"
  has_many :comments, foreign_key: "post_id", class_name: "Thing"
  has_many :bookmarks
  has_many :votes
  has_many :logs, as: :loggable

  enum thing_type: { post: 1, comment: 2 }
  enum content_type: { text: 1, link: 2, media: 3 }

  scope :thing_type, ->(type) { where(thing_type: type) if type.present? }

  scope :sort_records_by, -> (sort) do
    if sort.present?
      if sort == :new
        order(id: :desc)
      else
        order("#{sort}_score" => :desc, id: :desc)
      end
    end
  end

  scope :records_after, ->(record, sort) do
    if record.present?
      if sort == :new
        where("id < ?", record.id)
      else
        where("(#{sort}_score, id) < (?, ?)", record["#{sort}_score"], record.id)
      end
    end
  end

  scope :records_after_date, ->(date) { where("created_at > ?", date) if date.present? }

  before_create :normalize_url_on_create
  before_create :set_file_processing_attributes_on_file_cache
  before_update :reset_deletion_attributes_on_file_store
  after_create :create_topic_on_create
  after_create :insert_to_topic_on_create
  after_create :create_up_vote_on_create

  with_options if: ->(r) { r.post? } do
    validates :title, presence: true, length: { maximum: 350 }
  end

  with_options if: ->(r) { r.text? } do
    validates :text, presence: true, length: { maximum: 10_000 }
    validates :url, absence: true
    validates :file, absence: true
  end

  with_options if: ->(r) { r.link? } do
    validates :url, presence: true, length: { maximum: 2048 }
    validates :text, absence: true
    validates :file, absence: true
  end

  with_options if: ->(r) { r.link? && r.errors.blank? } do
    validate :validate_domain_not_blacklisted, on: :create
  end

  with_options if: ->(r) { r.media? } do
    validates :file, presence: true
    validates :text, absence: true
    validates :url, absence: true
  end

  validates :content_type, presence: true, inclusion: { in: self.content_types.keys }
  validates :tag, allow_blank: true, length: { maximum: 30 }

  def scores_stale?
    updated_at < 20.minutes.ago || (up_votes_count < 20 && down_votes_count < 20)
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

  def title=(value)
    super(value.squish)
  end

  def tag=(value)
    super(value&.squish)
  end

  def text=(value)
    super(value.strip)
  end

  def presenter
    @presenter ||= ThingPresenter.new(self)
  end

  def html_text
    return unless text?
    return @html_text if defined? (@html_text)

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

    @html_text = markdown.render(text)
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

  def set_file_processing_attributes_on_file_cache
    return unless media?
    return unless file_data_changed? && file_attacher.cached?

    assign_attributes(deleted_by: user, deleted_at: Time.current)
  end

  def reset_deletion_attributes_on_file_store
    return unless media?
    return unless file_data_changed? && file_attacher.stored?

    reset_deletion_attributes
  end

  def create_topic_on_create
    return unless post?

    create_topic!
  end

  def insert_to_topic_on_create
    return unless comment?

    json = {
      id: id,
      thing_id: reply_to.id,
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


end
