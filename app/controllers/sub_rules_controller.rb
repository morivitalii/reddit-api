# frozen_string_literal: true

class SubRulesController < BaseSubController
  before_action :set_rule, only: [:edit, :update, :confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: SubRulePolicy) }

  def index
    @records = Rule.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? @sub.rules.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def new
    @form = CreateSubRule.new

    render partial: "new"
  end

  def edit
    @form = UpdateSubRule.new(
      title: @rule.title,
      description: @rule.description
    )

    render partial: "edit"
  end

  def create
    @form = CreateSubRule.new(create_params)

    if @form.save
      head :no_content, location: sub_rules_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    @form = UpdateSubRule.new(update_params)

    if @form.save
      render partial: "sub_rules/rule", object: @form.rule
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteSubRule.new(rule: @rule, current_user: current_user).call

    head :no_content
  end

  private

  def set_rule
    @rule = @sub.rules.find(params[:id])
  end

  def create_params
    params.require(:create_sub_rule).permit(:title, :description).merge(sub: @sub, current_user: current_user)
  end

  def update_params
    params.require(:update_sub_rule).permit(:title, :description).merge(rule: @rule, current_user: current_user)
  end
end
