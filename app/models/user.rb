# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token :forgot_password_token

  has_one :staff
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

  delegate :staff?, :master?, :moderator?, :contributor?, :follower?, :banned?, to: :policy

  before_save :nullify_email_on_save

  def self.auto_moderator
    self.where("lower(users.username) = ?", "AutoModerator".downcase).take!
  end

  def to_param
    username
  end

  def cached_staff
    return @cached_staff if defined?(@cached_staff)

    @cached_staff = Rails.cache.fetch("user-staff-#{id}-#{staff_updated_at}", expires_in: 24.hours) do
      staff
    end
  end

  def cached_moderators
    return @cached_moderators if defined?(@cached_moderators)

    @cached_moderators = Rails.cache.fetch("user-moderators-#{id}-#{moderators_updated_at}", expires_in: 24.hours) do
      moderators.to_a
    end
  end

  def cached_contributors
    return @cached_contributors if defined?(@cached_contributors)

    @cached_contributors = Rails.cache.fetch("user-contributors-#{id}-#{contributors_updated_at}", expires_in: 24.hours) do
      contributors.to_a
    end
  end

  def cached_bans
    return @cached_bans if defined?(@cached_bans)

    @cached_bans = Rails.cache.fetch("user-bans-#{id}-#{bans_updated_at}", expires_in: 24.hours) do
      bans.to_a
    end
  end

  def cached_follows
    return @cached_follows if defined?(@cached_follows)

    @cached_follows = Rails.cache.fetch("user-follows-#{id}-#{follows_updated_at}", expires_in: 24.hours) do
      follows.to_a
    end
  end

  def policy
    @policy ||= ApplicationPolicy.new
  end

  private

  def nullify_email_on_save
    return unless email.blank?

    self.email = nil
  end
end
