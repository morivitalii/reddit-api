class Api::Communities::RulesController < ApplicationController
  before_action :set_community
  before_action :set_rule, only: [:update, :destroy]
  before_action -> { authorize(Api::Communities::RulesPolicy) }, only: [:index, :create]
  before_action -> { authorize(Api::Communities::RulesPolicy, @rule) }, only: [:update, :destroy]

  def index
    query = @community.rules.includes(:community)
    rules = paginate(
      query,
      attributes: [:id],
      order: :asc,
      limit: 25,
      after: params[:after].present? ? Rule.where(id: params[:after]).take : nil
    )

    render json: RuleSerializer.serialize(rules)
  end

  def create
    service = Communities::CreateRule.new(create_params)

    if service.call
      render json: RuleSerializer.serialize(service.rule)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    service = Communities::UpdateRule.new(update_params)

    if service.call
      render json: RuleSerializer.serialize(service.rule)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Communities::DeleteRule.new(rule: @rule).call

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
    params.permit(attributes).merge(community: @community)
  end

  def update_params
    attributes = Api::Communities::RulesPolicy.new(pundit_user, @rule).permitted_attributes
    params.permit(attributes).merge(rule: @rule)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
