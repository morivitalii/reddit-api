# frozen_string_literal: true

class RateLimit < ApplicationRecord
  belongs_to :user, touch: true
end
