# frozen_string_literal: true

class CreatePageForm
  include ActiveModel::Model

  attr_accessor :sub, :title, :text
  attr_reader :page

  def save
    @page = Page.create!(
      sub: sub,
      title: title,
      text: text
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
