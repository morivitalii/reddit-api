# frozen_string_literal: true

class UpdateSubTag
  include ActiveModel::Model

  attr_accessor :tag, :current_user, :title

  def save!
    @tag.update!(title: @title)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @tag.sub,
      current_user: @current_user,
      action: "update_sub_tag",
      model: @tag
    )
  end
end
