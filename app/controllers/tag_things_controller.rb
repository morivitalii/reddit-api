# frozen_string_literal: true

class TagThingsController < BaseThingController
  def edit
    TagThingPolicy.authorize!(:update, @thing)

    @form = UpdateThingTag.new(tag: @thing.tag)

    render partial: "edit"
  end

  def update
    TagThingPolicy.authorize!(:update, @thing)

    @form = UpdateThingTag.new(update_params.merge(thing: @thing, current_user: current_user))

    if @form.save
      render json: { tag: @form.thing.tag }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.require(:update_thing_tag).permit(:tag)
  end

  def set_thing
    @thing = @sub.things.thing_type(:post).find(params[:thing_id])
  end
end
