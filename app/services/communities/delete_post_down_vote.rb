class Communities::DeletePostDownVote
  attr_accessor :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    return false if vote.blank?

    ActiveRecord::Base.transaction do
      vote.destroy!
      post.decrement!(:down_votes_count)
      post.reload.update_scores!
    end
  end

  private

  def vote
    @_vote ||= post.votes.where(user: user, vote_type: :down).take
  end
end
