# frozen_string_literal: true

class Bookmark < ApplicationRecord
  include Paginatable

  belongs_to :thing
  belongs_to :user
end
