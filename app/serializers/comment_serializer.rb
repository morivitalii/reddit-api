# frozen_string_literal: true

class CommentSerializer
  include ActiveModel::Serializers::JSON

  attr_accessor :score, :up_vote_link, :down_vote_link
  attr_reader :comment, :decorated_comment

  def initialize(comment)
    @comment = comment
    @decorated_comment = comment.decorate
  end

  def attributes
    { score: nil, up_vote_link: nil, down_vote_link: nil }
  end

  def up_vote_link
    decorated_comment.up_vote_link
  end

  def down_vote_link
    decorated_comment.down_vote_link
  end

  def score
    decorated_comment.score
  end
end