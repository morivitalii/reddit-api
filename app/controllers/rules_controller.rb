# frozen_string_literal: true

class RulesController < ApplicationController
  before_action :set_rule, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(Rule, policy_class: RulePolicy) }

  def index
    @records = Rule.include(ChronologicalOrder)
                   .global
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? Rule.global.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    @form = CreateRule.new

    render partial: "new"
  end

  def edit
    @form = UpdateRule.new(
      title: @rule.title,
      description: @rule.description
    )

    render partial: "edit"
  end

  def create
    @form = CreateRule.new(create_params)

    if @form.save
      head :no_content, location: rules_path
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

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteRule.new(rule: @rule, current_user: current_user).call

    head :no_content
  end

  private

  def set_rule
    @rule = Rule.global.find(params[:id])
  end

  def create_params
    params.require(:create_rule).permit(:title, :description).merge(current_user: current_user)
  end

  def update_params
    params.require(:update_rule).permit(:title, :description).merge(rule: @rule, current_user: current_user)
  end
end
