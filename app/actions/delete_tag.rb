# frozen_string_literal: true

class DeleteTag
  def initialize(tag:, current_user:)
    @tag = tag
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @tag.destroy!

      CreateLog.new(
        sub: @tag.sub,
        current_user: @current_user,
        action: :delete_tag,
        attributes: [:title],
        model: @tag
      ).call
    end
  end
end
