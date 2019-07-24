# frozen_string_literal: true

class Page < ApplicationRecord
  include Paginatable
  include Editable

  belongs_to :sub, optional: true

  scope :global, -> { where(sub: nil) }

  validates :title, presence: true, length: { maximum: 350 }
  validates :text, presence: true, length: { maximum: 50_000 }

  def title=(value)
    super(value.squish)
  end

  def text=(value)
    super(value.strip)
  end

  def html_text
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
end
