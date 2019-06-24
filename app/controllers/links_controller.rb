# frozen_string_literal: true

class LinksController < BaseSubController
  def new
    LinkPolicy.authorize!(:create, @sub)

    @form = CreateLink.new
  end

  def create
    LinkPolicy.authorize!(:create, @sub)

    @form = CreateLink.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: thing_path(@sub, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:create_link).permit(:title, :url, :explicit, :spoiler)
  end
end
