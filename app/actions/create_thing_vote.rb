# frozen_string_literal: true

class CreateThingVote
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :type
  attr_reader :vote

  validates :type, presence: true, inclusion: { in: %w(down meh up) }

  def save
    return false if invalid?

    @vote = @thing.votes.where(user: @current_user).take

    if @vote.blank?
      @vote = @thing.votes.create!(vote_type: @type, user: @current_user)
    else
      @vote.update!(vote_type: @type, created_at: Time.current)
    end
  end
end
