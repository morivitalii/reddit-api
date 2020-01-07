class Post < ApplicationRecord
  include Paginatable
  include PostFileUploader::Attachment.new(:file)

  belongs_to :community
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  belongs_to :edited_by, class_name: "User", foreign_key: "edited_by_id", optional: true
  belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id", optional: true
  belongs_to :removed_by, class_name: "User", foreign_key: "removed_by_id", optional: true
  has_one :topic, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  before_create :approve_by_author, if: :author_has_permissions_to_approve?
  before_update :destroy_reports, if: -> { approving? }

  validates :title, presence: true, length: {maximum: 350}
  validates :removed_reason, allow_blank: true, length: {maximum: 5_000}

  with_options if: ->(r) { r.text.present? } do
    validates :text, length: {maximum: 10_000}
    validates :file, absence: true
  end

  with_options if: ->(r) { r.file.present? } do
    validates :text, absence: true
  end

  with_options if: ->(r) { r.text.blank? && r.file.blank? } do
    validates :file, presence: true
    validates :text, presence: true
  end

  def update_scores!
    update!(
      new_score: ScoreCalculator.new_score(created_at),
      hot_score: ScoreCalculator.hot_score(up_votes_count, down_votes_count, created_at),
      top_score: ScoreCalculator.top_score(up_votes_count, down_votes_count),
      controversy_score: ScoreCalculator.controversy_score(up_votes_count, down_votes_count),
    )
  end

  # def image_width
  #   width, _height = image_content_dimensions
  #   width
  # end
  #
  # def image_height
  #   _width, height = image_content_dimensions
  #   height
  # end

  private

  def approve_by_author
    assign_attributes(approved_by: created_by, approved_at: Time.current)
  end

  def approving?
    approved_at.present? && approved_at_changed?
  end

  def author_has_permissions_to_approve?
    context = Context.new(created_by, community)

    Api::Communities::Posts::ApprovePolicy.new(context, self).update?
  end

  def destroy_reports
    reports.destroy_all
  end

  # def image_content_dimensions
  #   return @_image_content_dimensions if defined?(@_image_content_dimensions)
  #
  #   variant = :desktop
  #
  #   if image[variant].height > 550
  #     coefficient_by_max_height = 550 / image[variant].height.to_f
  #     width_calculated_with_coefficient_by_max_height = (image[variant].width * coefficient_by_max_height).round
  #
  #     if width_calculated_with_coefficient_by_max_height < 350
  #       coefficient_by_min_width = 350 / image[variant].width.to_f
  #
  #       @_image_content_dimensions = [(image[variant].width * coefficient_by_min_width).round, (image[variant].height * coefficient_by_min_width).round]
  #     else
  #       @_image_content_dimensions = [width_calculated_with_coefficient_by_max_height, (image[variant].height * coefficient_by_max_height).round]
  #     end
  #   else
  #     @_image_content_dimensions = [image[variant].width, image[variant].height]
  #   end
  #
  #   @_image_content_dimensions
  # end
end
