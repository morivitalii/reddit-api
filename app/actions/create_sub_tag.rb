# frozen_string_literal: true

class CreateSubTag
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title
  attr_reader :tag

  def save!
    @tag = @sub.tags.create!(title: @title)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_sub_tag",
      model: @tag
    )
  end
end
