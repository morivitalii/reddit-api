# frozen_string_literal: true

class CreateTag
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title
  attr_reader :tag

  def save
    @tag = Tag.create!(
      sub: @sub,
      title: @title
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_tag",
      model: @tag
    )
  end
end
