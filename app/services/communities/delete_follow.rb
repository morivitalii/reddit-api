class Communities::DeleteFollow
  include ActiveModel::Model

  attr_accessor :community, :user

  def call
    community.follows.where(user: user).destroy_all
  end
end
