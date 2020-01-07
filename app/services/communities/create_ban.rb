class Communities::CreateBan
  include ActiveModel::Model

  attr_accessor :community, :username, :reason, :days, :permanent
  attr_reader :ban

  def call
    @ban = community.bans.create!(
      user: user,
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  private

  def user
    @_user ||= UsersQuery.new.with_username(username).take
  end
end
