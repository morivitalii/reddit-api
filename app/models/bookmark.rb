# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  belongs_to :user

  scope :type, -> (type) {
    if type.present?
      where(bookmarkable_type: type)
    end
  }
end
