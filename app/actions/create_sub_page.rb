# frozen_string_literal: true

class CreateSubPage
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :text
  attr_reader :page

  def save!
    @page = @sub.pages.create!(
      title: @title,
      text: @text,
      edited_by: @current_user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_sub_page",
      model: @page
    )
  end
end
