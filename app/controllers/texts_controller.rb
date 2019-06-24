# frozen_string_literal: true

class TextsController < BaseSubController
  before_action :set_thing, only: [:edit, :update]

  def new
    TextPolicy.authorize!(:create, @sub)

    @form = CreateText.new
  end

  def edit
    TextPolicy.authorize!(:update, @thing)

    @form = UpdateText.new(text: @thing.text)
  end

  def create
    TextPolicy.authorize!(:create, @sub)

    @form = CreateText.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: sub_thing_path(@sub, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    TextPolicy.authorize!(:update, @thing)

    @form = UpdateText.new(update_params.merge(post: @thing))

    if @form.save
      head :no_content, location: sub_thing_path(@sub, @form.post)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_thing
    @thing = @sub.things.thing_type(:post).where(content_type: :text).find(params[:id])
  end

  def create_params
    params.require(:create_text).permit(:title, :text, :explicit, :spoiler)
  end

  def update_params
    params.require(:update_text).permit(:text)
  end
end
