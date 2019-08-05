# frozen_string_literal: true

class RulesController < ApplicationController
  before_action :set_rule, only: [:edit, :update, :destroy]
  before_action :set_sub
  before_action :set_facade
  before_action -> { authorize(Rule) }, only: [:index, :new, :create]
  before_action -> { authorize(rule) }, only: [:edit, :update, :destroy]

  def index
    @records, @pagination = scope.paginate(after: params[:after])
  end

  def new
    @form = CreateRule.new

    render partial: "new"
  end

  def edit
    attributes = @rule.slice(:title, :description)

    @form = UpdateRule.new(attributes)

    render partial: "edit"
  end

  def create
    @form = CreateRule.new(create_params)

    if @form.save
      head :no_content, location: rules_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateRule.new(update_params)

    if @form.save
      render partial: "rule", object: @form.rule
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteRuleService.new(@rule).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def scope
    query_class = RulesQuery

    if @sub.present?
      query_class.new.sub(@sub)
    else
      query_class.new.global
    end
  end

  def set_facade
    @facade = RulesFacade.new(context)
  end

  def set_sub
    if @rule.present?
      @sub = @rule.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_rule
    @rule = Rule.find(params[:id])
  end

  def create_params
    attributes = policy(Rule).permitted_attributes_for_create

    params.require(:create_rule).permit(attributes).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    attributes = policy(@rule).permitted_attributes_for_update

    params.require(:update_rule).permit(attributes).merge(rule: @rule, current_user: current_user)
  end
end
