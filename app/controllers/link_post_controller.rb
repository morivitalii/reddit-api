# frozen_string_literal: true

class LinkPostController < BaseSubController
  def new
    LinkPostPolicy.authorize!(:create, @sub)

    @form = CreateLinkPost.new
  end

  def create
    LinkPostPolicy.authorize!(:create, @sub)

    @form = CreateLinkPost.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: thing_path(@sub, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:create_link_post).permit(:title, :url, :explicit, :spoiler)
  end
end
