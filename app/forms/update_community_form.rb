# frozen_string_literal: true

class UpdateCommunityForm
  include ActiveModel::Model

  attr_accessor :community, :title, :description

  def save
    community.update!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end

  def persisted?
    true
  end
end
