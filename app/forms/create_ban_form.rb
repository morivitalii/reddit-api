# frozen_string_literal: true

class CreateBanForm
  include ActiveModel::Model

  attr_accessor :sub, :username, :reason, :days, :permanent
  attr_reader :ban

  def save
    @ban = Ban.create!(
      sub: sub,
      user: user,
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  private

  def user
    @_user ||= UsersQuery.new.with_username(username).take
  end
end
