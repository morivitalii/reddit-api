# frozen_string_literal: true

class CommunitiesController < ApplicationController
  before_action :set_community
  before_action -> { authorize(@community) }
  decorates_assigned :community, :posts

  def show
    @posts, @pagination = query.paginate(attributes: ["#{sorting}_score", :id], after: params[:after])
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

  def pundit_user
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:id]).take!
  end

  def query
    query = PostsQuery.new(@community.posts).not_removed
    PostsQuery.new(query).search_created_after(date_value).includes(:user, :community)
  end

  def update_params
    attributes = policy(@community).permitted_attributes_for_update

    params.require(:update_community_form).permit(attributes).merge(community: @community)
  end

  helper_method :sorting
  def sorting
    sorting_options.include?(params[:sort]) ? params[:sort] : "hot"
  end

  helper_method :sorting_options
  def sorting_options
    %w(hot new top controversy)
  end

  helper_method :date
  def date
    date_options.include?(params[:date]) ? params[:date] : nil
  end

  helper_method :date_options
  def date_options
    %w(day week month)
  end

  def date_value
    # Time.now.advance does not accept string keys. wat?
    date.present? ? Time.now.advance("#{date}s".to_sym => -1) : nil
  end
end
