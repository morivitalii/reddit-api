# frozen_string_literal: true

class Moderator < ApplicationRecord
  belongs_to :sub, optional: true
  belongs_to :user
  belongs_to :invited_by, class_name: "User", foreign_key: "invited_by_id"

  before_create :delete_user_as_contributor_on_create, if: -> (record) { record.sub.present? }

  def self.search(query)
    joins(:user).where("lower(users.username) = ?", query)
  end

  private

  def delete_user_as_contributor_on_create
    user.contributors.where(sub: sub).destroy_all
  end
end
