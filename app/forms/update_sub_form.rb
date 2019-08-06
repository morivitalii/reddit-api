# frozen_string_literal: true

class UpdateSubForm
  include ActiveModel::Model

  attr_accessor :sub, :title, :description

  def save
    sub.update!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
