# frozen_string_literal: true

class ThingTagController < BaseThingController
  def edit
    ThingTagPolicy.authorize!(:update, @thing)

    @form = UpdateThingTag.new(tag: @thing.tag)

    render partial: "edit"
  end

  def update
    ThingTagPolicy.authorize!(:update, @thing)

    @form = UpdateThingTag.new(update_params.merge(thing: @thing, current_user: Current.user))
    @form.save!

    render json: { tag: @form.thing.tag }
  end

  private

  def update_params
    params.require(:update_thing_tag).permit(:tag)
  end

  def set_thing
    @thing = @sub.things.thing_type(:post).find(params[:id])
  end
end
