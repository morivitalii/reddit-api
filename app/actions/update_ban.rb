# frozen_string_literal: true

class UpdateBan
  include ActiveModel::Model

  attr_accessor :ban, :current_user, :reason, :days, :permanent

  def save
    ActiveRecord::Base.transaction do
      @ban.update!(
          reason: @reason,
          days: @days,
          permanent: @permanent
      )

      CreateLog.new(
          sub: @ban.sub,
          current_user: @current_user,
          action: :update_ban,
          loggable: @ban.user,
          attributes: [:reason, :days, :permanent],
          model: @ban
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def permanent=(value)
    @permanent = ActiveModel::Type::Boolean.new.cast(value)
  end
end
