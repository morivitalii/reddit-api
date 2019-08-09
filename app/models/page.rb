# frozen_string_literal: true

class Page < ApplicationRecord
  include Paginatable
  include Editable
  include Markdownable

  markdown_attributes :text

  belongs_to :sub, optional: true

  strip_attributes :title, squish: true
  strip_attributes :text

  validates :title, presence: true, length: { maximum: 350 }
  validates :text, presence: true, length: { maximum: 50_000 }
end
