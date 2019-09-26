# frozen_string_literal: true

class CreateComment
  include ActiveModel::Model

  attr_accessor :model, :current_user, :text
  attr_reader :comment

  def save
    ActiveRecord::Base.transaction do
      @comment = Comment.create!(
        user: @current_user,
        community: post.community,
        post: post,
        comment: comment,
        text: @text
      )

      @comment.votes.create!(vote_type: :up, user: @current_user)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  private

  def post
    @model.is_a?(Post) ? @model : @model.post
  end

  def comment
    @model.is_a?(Comment) ? @model : nil
  end
end
