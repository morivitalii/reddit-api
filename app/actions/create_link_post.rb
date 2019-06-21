# frozen_string_literal: true

class CreateLinkPost
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :url, :explicit, :spoiler
  attr_reader :post

  def save
    @post = @sub.things.create!(
      thing_type: :post,
      content_type: :link,
      user: @current_user,
      title: @title,
      url: @url,
      explicit: @explicit,
      spoiler: @spoiler
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
