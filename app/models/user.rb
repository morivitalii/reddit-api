# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token :forgot_password_token

  has_many :subs
  has_many :follows
  has_many :moderators
  has_many :contributors
  has_many :bans
  has_many :things
  has_many :bookmarks
  has_many :votes
  has_many :reports
  has_many :notifications
  has_many :logs
  has_many :rate_limits

  delegate :global_moderator?, :sub_moderator?, :moderator?, :global_contributor?, :sub_contributor?, :sub_follower?, :banned_in_sub?, :banned_globally?, to: :policy

  def self.auto_moderator
    self.where("lower(users.username) = ?", "AutoModerator".downcase).take!
  end

  def to_param
    username
  end

  def policy
    @policy ||= ApplicationPolicy.new(self, nil)
  end
end
