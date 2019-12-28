class Api::Communities::Posts::Comments::ReportsController < ApplicationController
  before_action :set_community
  before_action :set_post
  before_action :set_comment
  before_action -> { authorize(@comment, policy_class: Api::Communities::Posts::Comments::ReportsPolicy) }

  def index
    @reports = ReportsQuery.new(@comment.reports).recent(25).includes(:user).all

    render partial: "index"
  end

  def new
    @form = Communities::Posts::Comments::CreateReportForm.new
    @rules = @community.rules.all

    render partial: "new"
  end

  def create
    @form = Communities::Posts::Comments::CreateReportForm.new(create_params)

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

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end

  def create_params
    attributes = Api::Communities::Posts::Comments::ReportsPolicy.new(pundit_user, @comment).permitted_attributes_for_create
    params.require(:communities_posts_comments_create_report_form).permit(attributes).merge(comment: @comment, user: current_user)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
