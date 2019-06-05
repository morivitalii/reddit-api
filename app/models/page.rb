# frozen_string_literal: true

class Page < ApplicationRecord
  belongs_to :sub, optional: true, counter_cache: true
  belongs_to :edited_by, class_name: "User", foreign_key: "edited_by_id"

  scope :global, -> { where(sub: nil) }

  before_create :set_edited_at_on_create
  before_update :update_edited_at_on_edit
  before_save :text_to_html_on_create_or_edit

  validates :title, presence: true, length: { maximum: 350 }
  validates :text, presence: true, length: { maximum: 50_000 }

  def edited?
    created_at != edited_at
  end

  def title=(value)
    super(value.squish)
  end

  def text=(value)
    super(value.strip)
  end

  private

  def set_edited_at_on_create
    self.edited_at = created_at
  end

  def update_edited_at_on_edit
    return unless text_changed?

    self.edited_at = Time.current
  end

  def text_to_html_on_create_or_edit
    return unless text_changed?

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
