class Communities::CreateModerator
  include ActiveModel::Model

  attr_accessor :community, :user_id
  attr_reader :moderator

  def call
    @moderator = community.moderators.create!(user_id: user_id)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
