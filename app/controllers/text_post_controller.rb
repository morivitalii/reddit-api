# frozen_string_literal: true

class TextPostController < BaseSubController
  before_action :set_thing, only: [:edit, :update]

  def new
    TextPostPolicy.authorize!(:create, @sub)

    @form = CreateTextPost.new
  end

  def edit
    TextPostPolicy.authorize!(:update, @thing)

    @form = UpdateTextPost.new(text: @thing.text)
  end

  def create
    TextPostPolicy.authorize!(:create, @sub)

    @form = CreateTextPost.new(create_params.merge(sub: @sub, current_user: Current.user))
    @form.save!

    head :no_content, location: thing_path(@sub, @form.post)
  end

  def update
    TextPostPolicy.authorize!(:update, @thing)

    @form = UpdateTextPost.new(update_params.merge(post: @thing))
    @form.save!

    head :no_content, location: thing_path(@sub, @form.post)
  end

  private

  def set_thing
    # No index in db for content_type column
    @thing = @sub.things.thing_type(:post).where(content_type: :text).find(params[:id])
  end

  def create_params
    params.require(:create_text_post).permit(:title, :text, :explicit, :spoiler)
  end

  def update_params
    params.require(:update_text_post).permit(:text)
  end
end
