# frozen_string_literal: true

class CreateMediaPost
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :file, :explicit, :spoiler
  attr_reader :post

  def save
    @post = @sub.things.create!(
      thing_type: :post,
      content_type: :media,
      user: @current_user,
      title: @title,
      file: @file,
      explicit: @explicit,
      spoiler: @spoiler
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
