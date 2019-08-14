# frozen_string_literal: true

class Report < ApplicationRecord
  include Paginatable

  belongs_to :community, touch: true
  belongs_to :reportable, polymorphic: true, touch: true
  belongs_to :user, touch: true

  validates :text, presence: true, length: { maximum: 500 }
end
