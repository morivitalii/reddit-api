# frozen_string_literal: true

class MediasController < BaseSubController
  def new
    MediaPolicy.authorize!(:create, @sub)

    @form = CreateMedia.new
  end

  def create
    MediaPolicy.authorize!(:create, @sub)

    @form = CreateMedia.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: thing_path(@sub, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:create_media).permit(:title, :file, :explicit, :spoiler)
  end
end
