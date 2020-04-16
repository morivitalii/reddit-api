class Communities::CreateBan
  include ActiveModel::Model

  attr_accessor :community, :user_id, :reason, :days, :permanent
  attr_reader :ban

  def call
    @ban = community.bans.create!(
      user_id: user_id,
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
