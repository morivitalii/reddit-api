# frozen_string_literal: true

class UpdateSubModerator
  include ActiveModel::Model

  attr_accessor :moderator, :current_user, :master

  def save
    @moderator.update!(master: @master)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      sub: @moderator.sub,
      current_user: @current_user,
      action: "update_sub_moderator",
      loggable: @moderator.user,
      model: @moderator
    )
  end
end
