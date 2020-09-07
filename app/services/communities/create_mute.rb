class Communities::CreateMute
  include ActiveModel::Model

  attr_accessor :community, :created_by, :user_id, :end_at
  attr_reader :mute

  def call
    @mute = community.mutes.create!(
      created_by: created_by,
      updated_by: created_by,
      target_id: user_id,
      target_type: "User",
      end_at: end_at
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
