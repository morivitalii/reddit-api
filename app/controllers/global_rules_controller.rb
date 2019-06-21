# frozen_string_literal: true

class GlobalRulesController < ApplicationController
  before_action :set_rule, only: [:edit, :update, :confirm, :destroy]

  def index
    GlobalRulesPolicy.authorize!(:index)

    @records = Rule.include(ChronologicalOrder)
                   .global
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Rule.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.global_rules + 1)
                   .to_a

    if @records.size > PaginationLimits.global_rules
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    GlobalRulesPolicy.authorize!(:create)

    @form = CreateGlobalRule.new

    render partial: "new"
  end

  def edit
    GlobalRulesPolicy.authorize!(:update)

    @form = UpdateGlobalRule.new(
      title: @rule.title,
      description: @rule.description
    )

    render partial: "edit"
  end

  def create
    GlobalRulesPolicy.authorize!(:create)

    @form = CreateGlobalRule.new(create_params.merge(current_user: Current.user))

    if @form.save
      head :no_content, location: global_rules_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    GlobalRulesPolicy.authorize!(:update)

    @form = UpdateGlobalRule.new(update_params.merge(rule: @rule, current_user: Current.user))

    if @form.save
      render partial: "global_rules/rule", object: @form.rule
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    GlobalRulesPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    GlobalRulesPolicy.authorize!(:destroy)

    DeleteGlobalRule.new(rule: @rule, current_user: Current.user).call

    head :no_content
  end

  private

  def set_rule
    @rule = Rule.global.find(params[:id])
  end

  def create_params
    params.require(:create_global_rule).permit(:title, :description)
  end

  def update_params
    params.require(:update_global_rule).permit(:title, :description)
  end
end
