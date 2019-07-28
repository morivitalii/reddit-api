# frozen_string_literal: true

class CreatePage
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :title, :text
  attr_reader :page

  def save
    @page = Page.create!(
      sub: @sub,
      title: @title,
      text: @text,
      edited_by: @current_user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
