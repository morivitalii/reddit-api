# frozen_string_literal: true

class CreateComment
  include ActiveModel::Model

  attr_accessor :commentable_model, :current_user, :text
  attr_reader :comment

  def save
    ActiveRecord::Base.transaction do
      @comment = Comment.create!(
        user: @current_user,
        post: post,
        comment: comment,
        text: @text
      )

      @comment.create_self_up_vote!
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  private

  def post
    @commentable_model.is_a?(Post) ? @commentable_model : @commentable_model.post
  end

  def comment
    @commentable_model.is_a?(Comment) ? @commentable_model : nil
  end
end
