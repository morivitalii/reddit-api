class Communities::CreateFollowService
  attr_reader :community, :user

  def initialize(community, user)
    @community = community
    @user = user
  end

  def call
    follow.present? ? follow : community.follows.create!(user: user)
  end

  private

  def follow
    @_follow ||= community.follows.where(user: user).take
  end
end
