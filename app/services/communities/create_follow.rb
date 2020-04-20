class Communities::CreateFollow
  include ActiveModel::Model

  attr_accessor :community, :user

  def call
    follow.present? ? follow : community.follows.create!(user: user)
  end

  private

  def follow
    @_follow ||= community.follows.where(user: user).take
  end
end
