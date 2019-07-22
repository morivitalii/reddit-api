# frozen_string_literal: true

class UpdateTag
  include ActiveModel::Model

  attr_accessor :tag, :current_user, :title

  def save
    ActiveRecord::Base.transaction do
      @tag.update!(title: @title)

      CreateLog.new(
        sub: @tag.sub,
        current_user: @current_user,
        action: :update_tag,
        attributes: [:title],
        model: @tag
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
