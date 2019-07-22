# frozen_string_literal: true

class CreatePage
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :title, :text
  attr_reader :page

  def save
    ActiveRecord::Base.transaction do
      @page = Page.create!(
        sub: @sub,
        title: @title,
        text: @text,
        edited_by: @current_user
      )

      CreateLog.new(
        sub: @sub,
        current_user: @current_user,
        action: :create_page,
        attributes: [:title, :text],
        model: @page
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
