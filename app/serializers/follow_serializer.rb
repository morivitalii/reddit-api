class FollowSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      user: user,
      followable: followable,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end

  private

  def followable
    if model.association(:followable).loaded? && model.followable.present?
      if model.followable.is_a?(Community)
        CommunitySerializer.serialize(model.followable)
      end
    end
  end

  def user
    model.association(:user).loaded? && model.user.present? ? UserSerializer.serialize(model.user) : nil
  end
end
