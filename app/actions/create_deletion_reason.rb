# frozen_string_literal: true

class CreateDeletionReason
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :title, :description
  attr_reader :deletion_reason

  def save
    ActiveRecord::Base.transaction do
      @deletion_reason = DeletionReason.create!(
        sub: @sub,
        title: @title,
        description: @description
      )

      CreateLog.new(
        sub: @sub,
        current_user: @current_user,
        action: :create_contributor,
        model: @deletion_reason,
        attributes: [:title, :description]
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
