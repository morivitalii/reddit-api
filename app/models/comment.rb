# frozen_string_literal: true

class Comment < ApplicationRecord
  include Paginatable
  include Scorable
  include Editable
  include Approvable
  include Deletable
  include Notifiable
  include Reportable
  include Votable
  include Bookmarkable

  belongs_to :user
  belongs_to :post, counter_cache: :comments_count
  belongs_to :parent, class_name: "Comment", foreign_key: "parent_id", counter_cache: :comments_count, optional: true
  has_many :children, class_name: "Comment", foreign_key: "parent_id"
  has_many :logs, as: :loggable

  after_save :upsert_in_topic

  validates :text, presence: true, length: { maximum: 10_000 }

  def text=(value)
    super(value.strip)
  end

  def presenter
    @presenter ||= ThingPresenter.new(self)
  end

  def cut_text_preview?
    text.length > 800
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

  def upsert_in_topic
    json = {
      id: id,
      thing_id: reply_to.id,
      deleted: deleted?,
      scores: {
        best: best_score,
        top: top_score,
        controversy: controversy_score,
        created_at: created_at.to_i
      }
    }.to_json

    query = "UPDATE topics
             SET branch = jsonb_set(branch, '{#{id}}', '#{json}', true),
                 updated_at = '#{Time.current.strftime('%Y-%m-%d %H:%M:%S.%N')}'
             WHERE post_id = #{post_id};"

    ActiveRecord::Base.connection.execute(query)
  end
end
