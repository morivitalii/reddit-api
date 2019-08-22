# frozen_string_literal: true

class Vote < ApplicationRecord
  include Paginatable

  belongs_to :votable, polymorphic: true
  belongs_to :user

  enum vote_type: { up: 1, down: -1 }

  validates :user, uniqueness: { scope: [:votable_type, :votable_id] }
  validates :vote_type, presence: true

  after_create :update_counter_caches_on_create
  after_destroy :update_counter_caches_on_destroy
  after_create :recalculate_scores
  after_destroy :recalculate_scores

  private

  def update_counter_caches_on_create
    if up?
      votable.increment!(:up_votes_count)
    elsif down?
      votable.increment!(:down_votes_count)
    end
  end

  def update_counter_caches_on_destroy
    if up?
      votable.decrement!(:up_votes_count)
    elsif down?
      votable.decrement!(:down_votes_count)
    end
  end

  def recalculate_scores
    votable.recalculate_scores!
  end
end
