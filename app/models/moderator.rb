# frozen_string_literal: true

class Moderator < ApplicationRecord
  include Paginatable

  belongs_to :sub
  belongs_to :user
end
