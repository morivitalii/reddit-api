# frozen_string_literal: true

class Vote < ApplicationRecord
  include Paginatable

  belongs_to :votable, polymorphic: true
  belongs_to :user

  enum vote_type: { down: -1, up: 1 }

  validates :vote_type, presence: true, inclusion: { in: %w(down up) }

  after_save :update_votable_points_on_create
  after_destroy :update_votable_points_on_destroy
  after_save :update_user_points_on_create
  after_destroy :update_user_points_on_destroy
  after_save :update_scores
  after_destroy :update_scores

  private

  def update_votable_points_on_create
    if up?
      votable.increment!(:up_votes_count)
    elsif down?
      votable.increment!(:down_votes_count)
    end
  end

  def update_votable_points_on_destroy
    if up?
      votable.decrement!(:up_votes_count)
    elsif down?
      votable.decrement!(:down_votes_count)
    end
  end

  def update_user_points_on_create
    return if self_vote?

    if up?
      user.increment!(user_points_attribute)
    elsif down?
      user.decrement!(user_points_attribute)
    end
  end

  def update_user_points_on_destroy
    return if self_vote?

    if up?
      user.decrement!(user_points_attribute)
    elsif down?
      user.increment!(user_points_attribute)
    end
  end

  def update_scores
    votable.update_scores!
  end

  def user_points_attribute
    "#{votable.class.name.pluralize}_points"
  end

  def self_vote?
    user_id == votable.user_id
  end
end
