class Api::Communities::RulesController < ApplicationController
  before_action :set_community
  before_action :set_rule, only: [:edit, :update, :destroy]
  before_action -> { authorize(Api::Communities::RulesPolicy) }, only: [:index, :new, :create]
  before_action -> { authorize(Api::Communities::RulesPolicy, @rule) }, only: [:edit, :update, :destroy]

  def index
    @rules, @pagination = @community.rules.paginate(
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after]
    )
  end

  def new
    @form = Communities::CreateRule.new

    render partial: "new"
  end

  def edit
    attributes = @rule.slice(:title, :description)

    @form = Communities::UpdateRuleForm.new(attributes)

    render partial: "edit"
  end

  def create
    @form = Communities::CreateRule.new(create_params)

    if @form.save
      head :no_content, location: community_rules_path(@community)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = Communities::UpdateRuleForm.new(update_params)

    if @form.save
      render partial: "rule", object: @form.rule
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Communities::DeleteRuleService.new(@rule).call

    head :no_content
  end

  private

  def set_community
    @community = CommunitiesQuery.new.with_url(params[:community_id]).take!
  end

  def set_rule
    @rule = @community.rules.find(params[:id])
  end

  def create_params
    attributes = Api::Communities::RulesPolicy.new(pundit_user).permitted_attributes
    params.require(:communities_create_rule_form).permit(attributes).merge(community: @community)
  end

  def update_params
    attributes = Api::Communities::RulesPolicy.new(pundit_user, @rule).permitted_attributes
    params.require(:communities_update_rule_form).permit(attributes).merge(rule: @rule)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
