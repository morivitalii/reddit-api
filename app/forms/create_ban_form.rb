# frozen_string_literal: true

class CreateBanForm
  include ActiveModel::Model

  attr_accessor :community, :username, :reason, :days, :permanent
  attr_reader :ban

  def save
    @ban = Ban.create!(
      community: community,
      user: user,
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def persisted?
    false
  end

  private

  def user
    @_user ||= UsersQuery.new.with_username(username).take
  end
end
