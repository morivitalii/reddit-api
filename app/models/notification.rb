# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :notifiable, polymorphic: true

  scope :type, -> (type) {
    if type.present?
      where(notifiable_type: type)
    end
  }
end
