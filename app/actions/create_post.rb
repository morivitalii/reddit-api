# frozen_string_literal: true

class CreatePost
  include ActiveModel::Model

  attr_accessor :community, :current_user, :title, :text, :url, :image, :explicit, :spoiler
  attr_reader :post

  def save
    ActiveRecord::Base.transaction do
      @post = Post.create!(
        community: @community,
        user: @current_user,
        title: @title,
        text: @text,
        url: @url,
        image: @image,
        explicit: @explicit,
        spoiler: @spoiler
      )

      @post.votes.create!(vote_type: :up, user: @current_user)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
