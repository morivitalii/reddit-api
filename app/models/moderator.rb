# frozen_string_literal: true

class Moderator < ApplicationRecord
  include Paginatable

  belongs_to :sub
  belongs_to :user
  belongs_to :invited_by, class_name: "User", foreign_key: "invited_by_id"
end
