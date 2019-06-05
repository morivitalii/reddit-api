# frozen_string_literal: true

class UpdateSub
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :description

  def save!
    @sub.update!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      loggable: @sub,
      action: "update_sub_settings",
      model: @sub
    )
  end
end
