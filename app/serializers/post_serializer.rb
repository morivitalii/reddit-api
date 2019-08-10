# frozen_string_literal: true

class PostSerializer
  include ActiveModel::Serializers::JSON

  attr_accessor :score, :up_vote_link, :down_vote_link
  attr_reader :post, :decorated_post

  def initialize(post)
    @post = post
    @decorated_post = post.decorate
  end

  def attributes
    { score: nil, up_vote_link: nil, down_vote_link: nil }
  end

  def up_vote_link
    decorated_post.up_vote_link
  end

  def down_vote_link
    decorated_post.down_vote_link
  end

  def score
    decorated_post.score
  end
end