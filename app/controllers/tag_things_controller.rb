# frozen_string_literal: true

class TagThingsController < BaseThingController
  before_action -> { authorize(@thing, policy_class: TagThingPolicy) }

  def edit
    @form = UpdateThingTag.new(tag: @thing.tag)

    render partial: "edit"
  end

  def update
    @form = UpdateThingTag.new(update_params)

    if @form.save
      render json: { tag: @form.thing.tag }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.require(:update_thing_tag).permit(:tag).merge(thing: @thing, current_user: current_user)
  end

  def set_thing
    @thing = Thing.find(params[:id])
  end
end
