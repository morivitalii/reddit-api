# frozen_string_literal: true

class CreatePost
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :text, :url, :file, :explicit, :spoiler
  attr_reader :post

  def save
    ActiveRecord::Base.transaction do
      @post = Thing.create!(
        sub: @sub,
        thing_type: :post,
        content_type: content_type,
        user: @current_user,
        title: @title,
        text: @text,
        url: @url,
        file: @file,
        explicit: @explicit,
        spoiler: @spoiler
      )

      @post.create_self_up_vote!
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    if invalid.record.errors.include?(:content_type)
      errors.add(:text, :blank)
      errors.add(:url, :blank)
      errors.add(:file, :blank)
    end

    return false
  end

  private

  def content_type
    if file.present?
      :media
    elsif url.present?
      :link
    elsif text.present?
      :text
    end
  end
end
