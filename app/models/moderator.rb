# frozen_string_literal: true

class Moderator < ApplicationRecord
  include Paginatable

  belongs_to :sub, touch: true
  belongs_to :user, touch: true
end
