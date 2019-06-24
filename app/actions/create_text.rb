# frozen_string_literal: true

class CreateText
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :text, :explicit, :spoiler
  attr_reader :post

  def save
    @post = @sub.things.create!(
      thing_type: :post,
      content_type: :text,
      user: @current_user,
      title: @title,
      text: @text,
      explicit: @explicit,
      spoiler: @spoiler
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
