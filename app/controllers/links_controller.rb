# frozen_string_literal: true

class LinksController < BaseSubController
  before_action -> { authorize(@sub, policy_class: LinkPolicy) }

  def new
    @form = CreateLink.new
  end

  def create
    @form = CreateLink.new(create_params.merge(sub: @sub, current_user: current_user))

    if @form.save
      head :no_content, location: thing_path(@form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:create_link).permit(:title, :url, :explicit, :spoiler)
  end
end
