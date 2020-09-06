class Communities::CreateBan
  include ActiveModel::Model

  attr_accessor :community, :created_by, :user_id, :end_at
  attr_reader :ban

  def call
    @ban = community.bans.create!(
      target_id: user_id,
      target_type: "User",
      created_by: created_by,
      updated_by: created_by,
      end_at: end_at
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
