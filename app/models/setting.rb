# frozen_string_literal: true

class Setting < ApplicationRecord
  serialize :value, JSON

  validates :key, presence: true, uniqueness: true
  validates :value, presence: true
end
