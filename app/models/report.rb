# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :sub
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  scope :type, -> (type) {
    if type.present?
      where(reportable_type: type)
    end
  }

  validates :text, presence: true, length: { maximum: 500 }
end
