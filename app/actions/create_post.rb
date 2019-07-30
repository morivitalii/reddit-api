# frozen_string_literal: true

class CreatePost
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :title, :text, :url, :media, :explicit, :spoiler
  attr_reader :post

  def save
    ActiveRecord::Base.transaction do
      @post = Post.create!(
        sub: @sub,
        user: @current_user,
        title: @title,
        text: @text,
        url: @url,
        media: @media,
        explicit: @explicit,
        spoiler: @spoiler
      )

      @post.create_self_up_vote!
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
