class Context
  attr_accessor :user, :community

  def initialize(user, community)
    @user = user
    @community = community
  end
end
