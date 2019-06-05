# frozen_string_literal: true

class ModQueue < ApplicationRecord
  belongs_to :sub
  belongs_to :thing

  enum thing_type: { post: 1, comment: 2 }
  enum queue_type: { not_approved: 1, reported: 2 }

  scope :thing_type, ->(type) { where(thing_type: type) if type.present? }
  scope :queue_type, ->(type) { where(queue_type: type) if type.present? }

  before_validation :set_initial_attributes

  private

  def set_initial_attributes
    self.sub ||= thing.sub
    self.thing_type ||= thing.thing_type
  end
end
