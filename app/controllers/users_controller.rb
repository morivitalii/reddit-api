# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:posts_index, :comments_index]
  before_action -> { authorize(@user) }
  decorates_assigned :user, :posts, :comments

  def posts_index
    @posts, @pagination = posts_query.paginate(after: params[:after])
  end

  def comments_index
    @comments, @pagination = comments_query.paginate(after: params[:after])
  end

  def edit
    @user = current_user

    attributes = @user.slice(:email)

    @form = UpdateUserForm.new(attributes)
  end

  def update
    @form = UpdateUserForm.new(update_params)

    if @form.save
      head :no_content, location: edit_users_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = UsersQuery.new.with_username(params[:id]).take!
  end

  def posts_query
    PostsQuery.new(@user.posts).not_removed.includes(:community, :user)
  end

  def comments_query
    CommentsQuery.new(@user.comments).not_removed.includes(:community, :post, :user)
  end

  def update_params
    attributes = policy(@user).permitted_attributes_for_update
    params.require(:update_user_form).permit(attributes).merge(user: current_user)
  end
end
