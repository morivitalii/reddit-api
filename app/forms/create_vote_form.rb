# frozen_string_literal: true

class CreateVoteForm
  include ActiveModel::Model

  attr_accessor :votable, :user, :type
  attr_reader :vote

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      Vote.where(votable: votable, user: user).destroy_all
      @vote = Vote.create!(votable: votable, user: user, vote_type: type)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
