# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :thing
  belongs_to :user
end
