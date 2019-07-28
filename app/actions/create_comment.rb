# frozen_string_literal: true

class CreateComment
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :text
  attr_reader :comment

  def save
    ActiveRecord::Base.transaction do
      @comment = @thing.sub.things.create!(
        thing_type: :comment,
        content_type: :text,
        user: @current_user,
        post: @thing.post? ? @thing : @thing.post,
        comment: @thing.comment? ? @thing : nil,
        text: @text
      )

      @comment.create_self_up_vote!
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
