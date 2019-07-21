# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :thing
  belongs_to :user

  validates :text, presence: true, length: { maximum: 500 }
end
