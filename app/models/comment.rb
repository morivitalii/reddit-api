# frozen_string_literal: true

class Comment < ApplicationRecord
  include Paginatable
  include Editable
  include Approvable
  include Removable
  include Reportable
  include Votable
  include Bookmarkable
  include Markdownable

  markdown_attributes :text
  strip_attributes :text

  delegate :sub, to: :post

  belongs_to :user
  belongs_to :sub
  belongs_to :post, counter_cache: :comments_count
  belongs_to :parent, class_name: "Comment", foreign_key: "comment_id", counter_cache: :comments_count, optional: true
  has_many :comments, class_name: "Comment", foreign_key: "comment_id", dependent: :destroy

  after_save :upsert_in_topic

  validates :text, presence: true, length: { maximum: 10_000 }

  def cut_text_preview?
    text.length > 800
  end

  private

  def upsert_in_topic
    json = {
      id: id,
      # TODO fix it
      # thing_id: reply_to.id,
      deleted: removed?,
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
