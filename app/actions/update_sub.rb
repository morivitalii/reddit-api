# frozen_string_literal: true

class UpdateSub
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :description

  def save
    ActiveRecord::Base.transaction do
      @sub.update!(
        title: @title,
        description: @description
      )

      CreateLog.new(
        sub: @sub,
        current_user: @current_user,
        loggable: @sub,
        action: :update_sub_settings,
        attributes: [:title, :description],
        model: @sub
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
