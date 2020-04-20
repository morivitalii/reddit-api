class CommunitySerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      url: model.url,
      title: model.title,
      description: model.description,
      followers_count: model.followers_count,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end
end
