# frozen_string_literal: true

class Comment < ApplicationRecord
  include Paginatable
  include Removable
  include Reportable
  include Votable
  include Markdownable

  markdown_attributes :text
  strip_attributes :text

  belongs_to :user, touch: true
  belongs_to :community, touch: true
  belongs_to :post, counter_cache: :comments_count, touch: true
  belongs_to :parent, class_name: "Comment", foreign_key: "comment_id", counter_cache: :comments_count, optional: true
  has_many :comments, class_name: "Comment", foreign_key: "comment_id", dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id", touch: true, optional: true
  belongs_to :edited_by, class_name: "User", foreign_key: "edited_by_id", touch: true, optional: true

  after_save :upsert_in_topic
  before_create -> { approve(user) }, if: :auto_approve?
  before_update :undo_remove, if: :approving?
  before_update :undo_approve, if: :editing?

  validates :text, presence: true, length: { maximum: 10_000 }

  def cut_text_preview?
    text.length > 800
  end

  def approve!(user)
    approve(user)
    save!
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

  private

  def approve(user)
    assign_attributes(approved_by: user, approved_at: Time.current)
  end

  def undo_approve
    assign_attributes(approved_by: nil, approved_at: nil)
  end

  def approving?
    approved_at.present? && approved_at_changed?
  end

  def auto_approve?
    context = Context.new(user, community)
    Pundit.policy(context, self).approve?
  end

  def editing?
    edited_at.present? && edited_at_changed?
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
