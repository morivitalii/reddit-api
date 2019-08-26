# frozen_string_literal: true

class UpdatePostForm
  include ActiveModel::Model

  attr_accessor :post, :user, :text, :explicit, :spoiler, :ignore_reports

  def save
    attributes = {
      text: text,
      explicit: explicit,
      spoiler: spoiler,
      ignore_reports: ignore_reports
    }.compact

    if edited?
      post.edit(user)
    end

    @post.update!(attributes)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
    end

  private

  def edited?
    text.present? && post.text != text
  end
end