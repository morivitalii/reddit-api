class PostSerializer < ApplicationSerializer
  def attributes
    {
      id: model.id,
      community: model.community.present? ? CommunitySerializer.serialize(model.community) : nil,
      created_by: model.created_by.present? ? UserSerializer.serialize(model.created_by) : nil,
      edited_by: model.edited_by.present? ? UserSerializer.serialize(model.edited_by) : nil,
      approved_by: model.approved_by.present? ? UserSerializer.serialize(model.approved_by) : nil,
      removed_by: model.removed_by.present? ? UserSerializer.serialize(model.removed_by) : nil,
      title: model.title,
      tag: model.tag,
      text: model.text,
      file: file,
      removed_reason: model.removed_reason,
      explicit: model.explicit,
      spoiler: model.spoiler,
      ignore_reports: model.ignore_reports,
      comments_count: model.comments_count,
      up_votes_count: model.up_votes_count,
      down_votes_count: model.down_votes_count,
      new_score: model.new_score,
      hot_score: model.hot_score,
      top_score: model.top_score,
      controversy_score: model.controversy_score,
      edited_at: model.edited_at,
      approved_at: model.approved_at,
      removed_at: model.removed_at,
      created_at: model.created_at,
      updated_at: model.updated_at,
    }
  end

  private

  def file
    return nil if model.file.blank?

    {
      desktop: file_attributes(:desktop),
      mobile: file_attributes(:mobile)
    }
  end

  def file_attributes(version)
    file_data = model.file[version].data
    file_metadata = file_data["metadata"]

    {
      id: file_data.dig("id"),
      url: model.file_url(version),
      filename: file_metadata.dig("filename"),
      size: file_metadata.dig("size"),
      mime_type: file_metadata.dig("mime_type"),
      width: file_metadata.dig("width"),
      height: file_metadata.dig("height")
    }
  end
end