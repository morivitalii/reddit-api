# frozen_string_literal: true

class MediaPostController < BaseSubController
  def new
    MediaPostPolicy.authorize!(:create, @sub)

    @form = CreateMediaPost.new
  end

  def create
    MediaPostPolicy.authorize!(:create, @sub)

    @form = CreateMediaPost.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: thing_path(@sub, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:create_media_post).permit(:title, :file, :explicit, :spoiler)
  end
end
