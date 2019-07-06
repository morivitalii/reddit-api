# frozen_string_literal: true

class SubRulesController < BaseSubController
  before_action :set_rule, only: [:edit, :update, :confirm, :destroy]

  def index
    SubRulesPolicy.authorize!(:index, @sub)

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
    SubRulesPolicy.authorize!(:create, @sub)

    @form = CreateSubRule.new

    render partial: "new"
  end

  def edit
    SubRulesPolicy.authorize!(:update, @sub)

    @form = UpdateSubRule.new(
      title: @rule.title,
      description: @rule.description
    )

    render partial: "edit"
  end

  def create
    SubRulesPolicy.authorize!(:create, @sub)

    @form = CreateSubRule.new(create_params.merge(sub: @sub, current_user: current_user))

    if @form.save
      head :no_content, location: sub_rules_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    SubRulesPolicy.authorize!(:update, @sub)

    @form = UpdateSubRule.new(update_params.merge(rule: @rule, current_user: current_user))

    if @form.save
      render partial: "sub_rules/rule", object: @form.rule
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    SubRulesPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubRulesPolicy.authorize!(:destroy, @sub)

    DeleteSubRule.new(rule: @rule, current_user: current_user).call

    head :no_content
  end

  private

  def set_rule
    @rule = @sub.rules.find(params[:id])
  end

  def create_params
    params.require(:create_sub_rule).permit(:title, :description)
  end

  def update_params
    params.require(:update_sub_rule).permit(:title, :description)
  end
end
