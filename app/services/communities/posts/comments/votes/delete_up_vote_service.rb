class Communities::Posts::Comments::Votes::DeleteUpVoteService
  attr_accessor :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    return false if vote.blank?

    ActiveRecord::Base.transaction do
      vote.destroy!
      comment.decrement!(:up_votes_count)
      comment.reload.update_scores!
    end
  end

  private

  def vote
    @_vote ||= comment.votes.where(user: user, vote_type: :up).take
  end
end
