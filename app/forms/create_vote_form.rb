# frozen_string_literal: true

class CreateVoteForm
  include ActiveModel::Model

  attr_accessor :votable, :user, :type
  attr_reader :vote

  validates :type, presence: true, inclusion: { in: %w(down meh up) }

  def save
    return false if invalid?

    @vote = Vote.where(votable: votable, user: user).take

    if @vote.blank?
      @vote = votable.votes.create!(vote_type: type, user: user)
    else
      @vote.update!(vote_type: type)
    end
  end
end
