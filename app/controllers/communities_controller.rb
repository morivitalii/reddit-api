# frozen_string_literal: true

class CommunitiesController < ApplicationController
  before_action :set_community
  before_action :set_facade
  before_action -> { authorize(@community) }

  def show
    @records, @pagination = query.paginate(attributes: ["#{sort}_score", :id], after: params[:after])
    @records = @records.map(&:decorate)
  end

  def edit
    attributes = @community.slice(:title, :description)

    @form = UpdateCommunityForm.new(attributes)
  end

  def update
    @form = UpdateCommunityForm.new(update_params)

    if @form.save
      head :no_content, location: edit_community_path(@community)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def context
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:id]).take!
  end

  def set_facade
    @facade = CommunitiesFacade.new(context, @community)
  end

  def query
    query = PostsQuery.new(@community.posts).not_removed
    PostsQuery.new(query).search_created_after(date).includes(:user, :community)
  end

  def update_params
    attributes = policy(@community).permitted_attributes_for_update

    params.require(:update_community_form).permit(attributes).merge(community: @community)
  end

  def sort
    ThingsSorting.new(params[:sort]).key
  end

  def date
    ThingsDates.new(params[:date]).date
  end
end
