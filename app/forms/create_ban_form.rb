# frozen_string_literal: true

class CreateBanForm
  include ActiveModel::Model

  attr_accessor :banned_by, :sub, :username, :reason, :days, :permanent
  attr_reader :ban

  def save
    @ban = Ban.create!(
      sub: sub,
      banned_by: banned_by,
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
