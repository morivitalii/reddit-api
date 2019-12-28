class Post < ApplicationRecord
  include Paginatable
  include PostImageUploader::Attachment.new(:image)

  belongs_to :community
  belongs_to :user
  has_one :topic, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id", optional: true
  belongs_to :edited_by, class_name: "User", foreign_key: "edited_by_id", optional: true
  belongs_to :removed_by, class_name: "User", foreign_key: "removed_by_id", optional: true

  before_create :normalize_url_on_create
  after_create :create_topic_on_create
  before_create :approve_by_author, if: :author_has_permissions_to_approve?
  before_update :undo_remove, if: :approving?
  before_update :undo_approve, if: -> { editing? || removing? }
  before_update :destroy_reports, if: -> { approving? || removing? }

  validates :title, presence: true, length: {maximum: 350}
  validates :removed_reason, allow_blank: true, length: {maximum: 5_000}

  with_options if: ->(r) { r.text.present? } do
    validates :text, length: {maximum: 10_000}
    validates :url, absence: true
    validates :image, absence: true
  end

  with_options if: ->(r) { r.url.present? } do
    validates :url, length: {maximum: 2048}
    validate :validate_url_format
    validates :text, absence: true
    validates :image, absence: true
  end

  with_options if: ->(r) { r.image.present? } do
    validates :text, absence: true
    validates :url, absence: true
  end

  with_options if: ->(r) { r.text.blank? && r.url.blank? && r.image.blank? } do
    validates :image, presence: true
    validates :text, presence: true
    validates :url, presence: true
  end

  def approve!(user)
    update!(approved_by: user, approved_at: Time.current)
  end

  def approved?
    approved_at.present?
  end

  def edit(user)
    assign_attributes(edited_by: user, edited_at: Time.current)
  end

  def edited?
    edited_at.present?
  end

  def remove!(user, reason = nil)
    update!(removed_by: user, removed_at: Time.current, removed_reason: reason)
  end

  def removed?
    removed_at.present?
  end

  def update_scores!
    update!(
      new_score: ScoreCalculator.new_score(created_at),
      hot_score: ScoreCalculator.hot_score(up_votes_count, down_votes_count, created_at),
      top_score: ScoreCalculator.top_score(up_votes_count, down_votes_count),
      controversy_score: ScoreCalculator.controversy_score(up_votes_count, down_votes_count),
    )
  end

  def image_width
    width, _height = image_content_dimensions
    width
  end

  def image_height
    _width, height = image_content_dimensions
    height
  end

  private

  def validate_url_format
    uri = Addressable::URI.parse(url).normalize

    unless uri.present? && uri.host.present? && uri.scheme.in?(%w[http https])
      errors.add(:url, :invalid)
    end
  rescue
    errors.add(:url, :invalid)
  end

  def approve_by_author
    assign_attributes(approved_by: user, approved_at: Time.current)
  end

  def undo_approve
    assign_attributes(approved_by: nil, approved_at: nil)
  end

  def approving?
    approved_at.present? && approved_at_changed?
  end

  def author_has_permissions_to_approve?
    context = Context.new(user, community)
    Api::Communities::Posts::ApprovePolicy.new(context, self).update?
  end

  def editing?
    edited_at.present? && edited_at_changed?
  end

  def undo_remove
    assign_attributes(removed_by: nil, removed_at: nil, removed_reason: nil)
  end

  def removing?
    removed_at.present? && removed_at_changed?
  end

  def destroy_reports
    reports.destroy_all
  end

  def normalize_url_on_create
    return if url.blank?

    self.url = Addressable::URI.parse(url).normalize.to_s
  end

  def create_topic_on_create
    create_topic!
  end

  def image_content_dimensions
    return @_image_content_dimensions if defined?(@_image_content_dimensions)

    variant = :desktop

    if image[variant].height > 550
      coefficient_by_max_height = 550 / image[variant].height.to_f
      width_calculated_with_coefficient_by_max_height = (image[variant].width * coefficient_by_max_height).round

      if width_calculated_with_coefficient_by_max_height < 350
        coefficient_by_min_width = 350 / image[variant].width.to_f

        @_image_content_dimensions = [(image[variant].width * coefficient_by_min_width).round, (image[variant].height * coefficient_by_min_width).round]
      else
        @_image_content_dimensions = [width_calculated_with_coefficient_by_max_height, (image[variant].height * coefficient_by_max_height).round]
      end
    else
      @_image_content_dimensions = [image[variant].width, image[variant].height]
    end

    @_image_content_dimensions
  end
end
