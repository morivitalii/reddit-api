class Communities::DeleteFollow
  attr_reader :community, :user

  def initialize(community, user)
    @community = community
    @user = user
  end

  def call
    community.follows.where(user: user).destroy_all
  end
end
