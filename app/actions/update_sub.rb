# frozen_string_literal: true

class UpdateSub
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :description

  def save
    @sub.update!(
      title: @title,
      description: @description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
