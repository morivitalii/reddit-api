class BanSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      source: source,
      target: target,
      created_by: created_by,
      updated_by: updated_by,
      end_at: model.end_at,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end

  private

  def source
    if model.association(:source).loaded? && model.source.present?
      if model.source.is_a?(Community)
        CommunitySerializer.serialize(model.source)
      end
    end
  end

  def target
    if model.association(:target).loaded? && model.target.present?
      if model.target.is_a?(User)
        UserSerializer.serialize(model.target)
      end
    end
  end

  def created_by
    if model.association(:created_by).loaded? && model.created_by.present?
      if model.created_by.is_a?(User)
        UserSerializer.serialize(model.created_by)
      end
    end
  end

  def updated_by
    if model.association(:updated_by).loaded? && model.updated_by.present?
      if model.updated_by.is_a?(User)
        UserSerializer.serialize(model.updated_by)
      end
    end
  end
end
