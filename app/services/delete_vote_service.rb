# frozen_string_literal: true

class DeleteVoteService
  attr_accessor :votable, :user

  def initialize(votable, user)
    @votable = votable
    @user = user
  end

  def call
    Vote.where(votable: votable, user: user).destroy_all
  end
end