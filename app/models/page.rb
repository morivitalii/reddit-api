# frozen_string_literal: true

class Page < ApplicationRecord
  include Paginatable
  include Editable
  include Markdownable

  belongs_to :sub

  markdown_attributes :text
  strip_attributes :title, squish: true
  strip_attributes :text

  validates :title, presence: true, length: { maximum: 350 }
  validates :text, presence: true, length: { maximum: 50_000 }
end
