# frozen_string_literal: true

class Contributor < ApplicationRecord
  belongs_to :sub, optional: true
  belongs_to :user
  belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id"

  def self.search(query)
    joins(:user).where("lower(users.username) = ?", query)
  end
end
