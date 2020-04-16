class ExileSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      user: user,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end

  private

  def user
    model.association(:user).loaded? && model.user.present? ? UserSerializer.serialize(model.user) : nil
  end
end