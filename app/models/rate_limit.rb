# frozen_string_literal: true

class RateLimit < ApplicationRecord
  belongs_to :user

  scope :todays, -> { where(created_at: 1.day.ago..Time.now) }
end
