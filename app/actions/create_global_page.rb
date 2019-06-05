# frozen_string_literal: true

class CreateGlobalPage
  include ActiveModel::Model

  attr_accessor :current_user, :title, :text
  attr_reader :page

  def save!
    @page = Page.create!(
      title: @title,
      text: @text,
      edited_by: @current_user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "create_global_page",
      model: @page
    )
  end
end
