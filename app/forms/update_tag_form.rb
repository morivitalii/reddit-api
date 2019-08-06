# frozen_string_literal: true

class UpdateTagForm
  include ActiveModel::Model

  attr_accessor :tag, :title

  def save
    tag.update!(title: title)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
