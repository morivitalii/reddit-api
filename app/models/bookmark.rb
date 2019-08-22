# frozen_string_literal: true

class Bookmark < ApplicationRecord
  include Paginatable

  belongs_to :bookmarkable, polymorphic: true
  belongs_to :user
end
