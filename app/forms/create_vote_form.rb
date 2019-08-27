# frozen_string_literal: true

class CreateVoteForm
  include ActiveModel::Model

  attr_accessor :votable, :user, :type
  attr_reader :vote

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      previous_vote&.destroy!
      @vote = Vote.create!(votable: votable, user: user, vote_type: type)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def persisted?
    false
  end

  private

  def previous_vote
    @_previous_vote ||= Vote.where(votable: votable, user: user).take
  end
end
