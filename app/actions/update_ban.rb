# frozen_string_literal: true

class UpdateBan
  include ActiveModel::Model

  attr_accessor :ban, :current_user, :reason, :days, :permanent

  def save
    @ban.update!(
      reason: @reason,
      days: @days,
      permanent: @permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "update_global_ban",
      loggable: @ban.user,
      model: @ban
    )
  end

  def permanent=(value)
    @permanent = ActiveModel::Type::Boolean.new.cast(value)
  end
end
