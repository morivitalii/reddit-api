class CommunitiesController < ApplicationController
  before_action :set_community
  before_action -> { authorize(@community, policy_class: CommunitiesPolicy) }
  decorates_assigned :community, :posts

  def show
    @posts, @pagination = query.paginate(attributes: [sort_attribute, :id], after: params[:after])
  end

  def edit
    attributes = @community.slice(:title, :description)

    @form = Communities::UpdateForm.new(attributes)
  end

  def update
    @form = Communities::UpdateForm.new(update_params)

    if @form.save
      head :no_content, location: edit_community_path(@community)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:id]).take!
  end

  def query
    query = PostsQuery.new(@community.posts).not_removed
    PostsQuery.new(query).search_created_after(date_value).includes(:user, :community)
  end

  def update_params
    attributes = CommunitiesPolicy.new(pundit_user, @community).permitted_attributes_for_update
    params.require(:update_community_form).permit(attributes).merge(community: @community)
  end

  helper_method :sorts
  def sorts
    %w[hot new top controversy]
  end

  helper_method :sort
  def sort
    sorts.include?(params[:sort]) ? params[:sort] : "hot"
  end

  def sort_attribute
    "#{sort}_score"
  end

  helper_method :dates
  def dates
    %w[day week month]
  end

  helper_method :date
  def date
    dates.include?(params[:date]) ? params[:date] : nil
  end

  def date_value
    # Time.now.advance does not accept string keys. wat?
    date.present? ? Time.now.advance("#{date}s".to_sym => -1) : nil
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
