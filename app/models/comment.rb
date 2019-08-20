# frozen_string_literal: true

class Comment < ApplicationRecord
  include Paginatable
  include Markdownable

  belongs_to :user, touch: true
  belongs_to :community, touch: true
  belongs_to :post, counter_cache: :comments_count, touch: true
  belongs_to :parent, class_name: "Comment", foreign_key: "comment_id", counter_cache: :comments_count, optional: true
  has_many :comments, class_name: "Comment", foreign_key: "comment_id", dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id", touch: true, optional: true
  belongs_to :edited_by, class_name: "User", foreign_key: "edited_by_id", touch: true, optional: true
  belongs_to :removed_by, class_name: "User", foreign_key: "removed_by_id", touch: true, optional: true

  alias_attribute :score, :top_score
  attribute :vote, default: nil

  markdown_attributes :text
  strip_attributes :text
  strip_attributes :removed_reason, squish: true

  after_save :upsert_in_topic
  before_create :approve_by_author, if: :author_has_permissions_to_approve?
  before_update :undo_remove, if: :approving?
  before_update :undo_approve, if: -> { editing? || removing? }
  after_update :destroy_reports, if: -> { approving? || removing? }

  validates :text, presence: true, length: { maximum: 10_000 }
  validates :removed_reason, allow_blank: true, length: { maximum: 5_000 }

  def cut_text_preview?
    text.length > 800
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

  def recalculate_scores!
    update!(
      new_score: ScoreCalculator.new_score(created_at),
      hot_score: ScoreCalculator.hot_score(up_votes_count, down_votes_count, created_at),
      best_score: ScoreCalculator.best_score(up_votes_count, down_votes_count),
      top_score: ScoreCalculator.top_score(up_votes_count, down_votes_count),
      controversy_score: ScoreCalculator.controversy_score(up_votes_count, down_votes_count),
    )
  end

  private

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
    Pundit.policy(context, self).approve?
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

  def upsert_in_topic
    json = {
      id: id,
      # TODO fix it
      # thing_id: reply_to.id,
      removed: removed?,
      new_score: new_score,
      hot_score: hot_score,
      best_score: best_score,
      top_score: top_score,
      controversy_score: controversy_score
    }.to_json

    query = "UPDATE topics
             SET branch = jsonb_set(branch, '{#{id}}', '#{json}', true),
                 updated_at = '#{Time.current.strftime('%Y-%m-%d %H:%M:%S.%N')}'
             WHERE post_id = #{post_id};"

    ActiveRecord::Base.connection.execute(query)
  end
end
