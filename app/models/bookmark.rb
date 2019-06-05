# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :thing
  belongs_to :user

  enum thing_type: { post: 1, comment: 2 }

  scope :thing_type, ->(type) { where(thing_type: type) if type.present? }

  before_validation :set_initial_attributes

  private

  def set_initial_attributes
    self.thing_type ||= thing.thing_type
  end
end
