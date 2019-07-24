# frozen_string_literal: true

class Vote < ApplicationRecord
  include Paginatable

  belongs_to :thing
  belongs_to :user

  enum vote_type: { down: -1, meh: 0, up: 1 }

  scope :vote_type, ->(type) { where(vote_type: type) if type.present? }

  after_save :update_thing_counter_cache
  after_save :update_user_points
  after_save :update_thing_scores
  after_save :update_comment_scores_in_topic

  private

  def update_thing_counter_cache
    previous = vote_type_previous_change&.compact
    return if previous == %w(meh)

    if previous == %w(up) || previous == %w(meh up)
      thing.increment!(:up_votes_count)
    elsif previous == %w(down) || previous == %w(meh down)
      thing.increment!(:down_votes_count)
    elsif previous == %w(up meh)
      thing.decrement!(:up_votes_count)
    elsif previous == %w(down meh)
      thing.decrement!(:down_votes_count)
    elsif previous == %w(up down)
      thing.increment!(:down_votes_count)
      thing.decrement!(:up_votes_count)
    elsif previous == %w(down up)
      thing.increment!(:up_votes_count)
      thing.decrement!(:down_votes_count)
    end
  end

  def update_user_points
    previous = vote_type_previous_change&.compact
    return if previous == %w(meh)
    return if user_id == thing.user_id

    user_points_attribute = thing.post? ? :posts_points : :comments_points

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

  def update_thing_scores
    if thing.scores_stale?
      thing.refresh_scores!
    end
  end

  def update_comment_scores_in_topic
    return unless thing.comment?
    return unless thing.scores_stale?

    json = {
      new_score: thing.new_score,
      hot_score: thing.hot_score,
      best_score: thing.best_score,
      top_score: thing.top_score,
      controversy_score: thing.controversy_score
    }.to_json

    ActiveRecord::Base.connection.execute(
      "UPDATE topics SET branch = jsonb_set(branch, '{#{thing.id}, scores}', '#{json}', false), updated_at = '#{Time.current.strftime('%Y-%m-%d %H:%M:%S.%N')}' WHERE post_id = #{thing.post_id};"
    )
  end
end
