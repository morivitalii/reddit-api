# frozen_string_literal: true

class Vote < ApplicationRecord
  include Paginatable

  belongs_to :votable, polymorphic: true, touch: true
  belongs_to :user

  enum vote_type: { down: -1, meh: 0, up: 1 }

  scope :vote_type, ->(type) { where(vote_type: type) if type.present? }

  scope :type, -> (type) {
    if type.present?
      where(votable_type: type)
    end
  }

  after_save :update_votable_counter_cache
  after_save :update_user_points

  private

  def update_votable_counter_cache
    previous = vote_type_previous_change&.compact
    return if previous == %w(meh)

    if previous == %w(up) || previous == %w(meh up)
      votable.increment!(:up_votes_count)
    elsif previous == %w(down) || previous == %w(meh down)
      votable.increment!(:down_votes_count)
    elsif previous == %w(up meh)
      votable.decrement!(:up_votes_count)
    elsif previous == %w(down meh)
      votable.decrement!(:down_votes_count)
    elsif previous == %w(up down)
      votable.increment!(:down_votes_count)
      votable.decrement!(:up_votes_count)
    elsif previous == %w(down up)
      votable.increment!(:up_votes_count)
      votable.decrement!(:down_votes_count)
    end
  end

  def update_user_points
    previous = vote_type_previous_change&.compact
    return if previous == %w(meh)
    return if user_id == votable.user_id

    user_points_attribute = votable.post? ? :posts_points : :comments_points

    if previous == %w(up) || previous == %w(meh up)
      user.increment!(user_points_attribute)
    elsif previous == %w(down) || previous == %w(meh down)
      user.decrement!(user_points_attribute)
    elsif previous == %w(up meh)
      user.decrement!(user_points_attribute)
    elsif previous == %w(down meh)
      user.increment!(user_points_attribute)
    elsif previous == %w(up down)
      user.decrement!(user_points_attribute, 2)
    elsif previous == %w(down up)
      user.increment!(user_points_attribute, 2)
    end
  end
end
