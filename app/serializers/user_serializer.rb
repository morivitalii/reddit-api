class UserSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      username: model.username,
      created_at: model.created_at,
      updated_at: model.updated_at,
    }
  end
end
