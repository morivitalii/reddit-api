# frozen_string_literal: true

class UpdateTag
  include ActiveModel::Model

  attr_accessor :tag, :current_user, :title

  def save
    @tag.update!(title: @title)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
