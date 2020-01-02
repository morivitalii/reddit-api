class Api::Communities::Posts::ReportsController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action -> { authorize(Api::Communities::Posts::ReportsPolicy, @post) }

  def index
    @reports = query.all

    render partial: "index"
  end

  def new
    @form = Communities::Posts::CreateReportForm.new
    @rules = @community.rules.all

    render partial: "new"
  end

  def create
    @form = Communities::Posts::CreateReportForm.new(create_params)

    if @form.save
      render json: t(".success")
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_post
    @post = @community.posts.find(params[:post_id])
  end

  def query
    ReportsQuery.new(@post.reports).recent(25).includes(:user)
  end

  def create_params
    attributes = Api::Communities::Posts::ReportsPolicy.new(pundit_user, @post).permitted_attributes_for_create
    params.require(:communities_posts_create_report_form).permit(attributes).merge(post: @post, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
