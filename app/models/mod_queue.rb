# frozen_string_literal: true

class ModQueue < ApplicationRecord
  belongs_to :thing

  enum queue_type: { not_approved: 1, reported: 2 }

  scope :queue_type, ->(type) { where(queue_type: type) if type.present? }
end
