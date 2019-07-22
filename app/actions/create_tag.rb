# frozen_string_literal: true

class CreateTag
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title
  attr_reader :tag

  def save
    ActiveRecord::Base.transaction do
      @tag = Tag.create!(
        sub: @sub,
        title: @title
      )

      CreateLog.new(
        sub: @sub,
        current_user: @current_user,
        action: :create_tag,
        attributes: [:title],
        model: @tag
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
