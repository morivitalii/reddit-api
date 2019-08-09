# frozen_string_literal: true

class Page < ApplicationRecord
  include Paginatable
  include Editable
  include Markdownable

  markdown_attributes :text

  belongs_to :sub, optional: true

  validates :title, presence: true, length: { maximum: 350 }
  validates :text, presence: true, length: { maximum: 50_000 }

  def title=(value)
    super(value.squish)
  end

  def text=(value)
    super(value.strip)
  end
end
