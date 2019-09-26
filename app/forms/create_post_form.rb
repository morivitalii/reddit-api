# frozen_string_literal: true

class CreatePostForm
  include ActiveModel::Model

  attr_accessor :community, :user, :title, :text, :url, :image, :explicit, :spoiler
  attr_reader :post

  def save
    ActiveRecord::Base.transaction do
      @post = Post.create!(
        community: community,
        user: user,
        title: title,
        text: text,
        url: url,
        image: image,
        explicit: explicit,
        spoiler: spoiler
      )

      post.votes.create!(vote_type: :up, user: user)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  def persisted?
    false
  end
end
