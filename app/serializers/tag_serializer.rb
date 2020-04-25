class TagSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      community: community,
      text: model.text,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end

  private

  def community
    model.association(:community).loaded? && model.community.present? ? CommunitySerializer.serialize(model.community) : nil
  end
end
