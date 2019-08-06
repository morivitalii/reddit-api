# frozen_string_literal: true

class UpdatePageForm
  include ActiveModel::Model

  attr_accessor :page, :edited_by, :title, :text

  def save
    page.edit(edited_by)

    page.update!(
      title: title,
      text: text
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
