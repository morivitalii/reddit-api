class Api::Users::Votes::Ups::PostsController < ApplicationController
  before_action :set_user
  before_action -> { authorize(Api::Users::Votes::Ups::PostsPolicy, @user) }

  def index
    posts_ids_query = VotesQuery.new(@user.votes).for_posts
    posts_ids_query = VotesQuery.new(posts_ids_query).up_votes
    posts_ids_query = paginate(
      posts_ids_query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: after
    )

    posts_ids = posts_ids_query.map(&:votable_id)

    posts_query = Post.where(id: posts_ids)
    posts_query = posts_query.includes(:community, :created_by, :edited_by, :approved_by, :removed_by)
    posts = posts_query.sort_by { |post| posts_ids.index(post.id) }

    render json: PostSerializer.serialize(posts)
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:user_id]).take!
  end

  def after
    if params[:after].present?
      query = VotesQuery.new(@user.votes).for_posts
      query = VotesQuery.new(query).up_votes

      query.where(votable_id: params[:after]).take
    end
  end
end
