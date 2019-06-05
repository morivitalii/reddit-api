# frozen_string_literal: true

class UpdateThingComment
  include ActiveModel::Model

  attr_accessor :comment, :text

  def save!
    @comment.update!(text: @text)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  end
end
