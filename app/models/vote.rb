# frozen_string_literal: true

class Vote < ApplicationRecord
  include Paginatable

  belongs_to :votable, polymorphic: true
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
  after_save :update_votable_scores
  after_save :update_comment_scores_in_topic

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

  def update_votable_scores
    if votable.scores_stale?
      votable.refresh_scores!
    end
  end

  def update_comment_scores_in_topic
    return unless votable.comment?
    return unless votable.scores_stale?

    json = {
      new_score: votable.new_score,
      hot_score: votable.hot_score,
      best_score: votable.best_score,
      top_score: votable.top_score,
      controversy_score: votable.controversy_score
    }.to_json

    ActiveRecord::Base.connection.execute(
      "UPDATE topics SET branch = jsonb_set(branch, '{#{votable.id}, scores}', '#{json}', false), updated_at = '#{Time.current.strftime('%Y-%m-%d %H:%M:%S.%N')}' WHERE post_id = #{votable.post_id};"
    )
  end
end
