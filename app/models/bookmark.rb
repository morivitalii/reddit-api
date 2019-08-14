# frozen_string_literal: true

class Bookmark < ApplicationRecord
  include Paginatable

  belongs_to :bookmarkable, polymorphic: true, touch: true
  belongs_to :user, touch: true
end
