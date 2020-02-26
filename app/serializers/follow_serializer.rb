class FollowSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      community: community,
      user: user,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end

  private

  def community
    model.association(:community).loaded? && model.community.present? ? CommunitySerializer.serialize(model.community) : nil
  end

  def user
    model.association(:user).loaded? && model.user.present? ? UserSerializer.serialize(model.user) : nil
  end
end