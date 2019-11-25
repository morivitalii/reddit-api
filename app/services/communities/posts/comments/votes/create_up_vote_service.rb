class Communities::Posts::Comments::Votes::CreateUpVoteService
  attr_accessor :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    return previous_vote if user_have_same_opinion?

    ActiveRecord::Base.transaction do
      if user_changed_opinion?
        previous_vote.destroy!
      end

      vote = comment.votes.create!(user: user, vote_type: :up)

      if user_changed_opinion?
        Comment.update_counters(comment.id, {up_votes_count: 1, down_votes_count: -1})
      else
        comment.increment!(:up_votes_count)
      end

      comment.reload.update_scores!

      vote
    end
  end

  private

  def previous_vote
    @_previous_vote ||= comment.votes.where(user: user).take
  end

  def user_have_same_opinion?
    previous_vote.present? && previous_vote.up?
  end

  def user_changed_opinion?
    previous_vote.present? && previous_vote.down?
  end
end
