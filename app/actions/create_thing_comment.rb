# frozen_string_literal: true

class CreateThingComment
  include ActiveModel::Model

  attr_accessor :thing, :current_user, :text
  attr_reader :comment

  def save
    @comment = @thing.sub.things.create!(
      thing_type: :comment,
      content_type: :text,
      user: @current_user,
      post: @thing.post? ? @thing : @thing.post,
      comment: @thing.comment? ? @thing : nil,
      text: @text
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
