class ReportSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      user: user,
      community: community,
      reportable: reportable,
      text: model.text,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end

  private

  def user
    model.association(:user).loaded? && model.user.present? ? UserSerializer.serialize(model.user) : nil
  end

  def community
    model.association(:community).loaded? && model.community.present? ? CommunitySerializer.serialize(model.community) : nil
  end

  def reportable
    if model.association(:reportable).loaded? && model.reportable.present?
      if model.reportable.is_a?(Post)
        PostSerializer.serialize(model.reportable)
      elsif model.reportable.is_a?(Comment)
        CommentSerializer.serialize(model.reportable)
      end
    end
  end
end
