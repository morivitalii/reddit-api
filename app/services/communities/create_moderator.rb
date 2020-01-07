class Communities::CreateModerator
  include ActiveModel::Model

  attr_accessor :community, :username
  attr_reader :moderator

  def call
    @moderator = community.moderators.create!(user: user)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  private

  def user
    @_user = UsersQuery.new.with_username(username).take
  end
end
