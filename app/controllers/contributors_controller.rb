# frozen_string_literal: true

class ContributorsController < ApplicationController
  before_action :set_contributor, only: [:destroy]
  before_action :set_sub
  before_action -> { authorize(Contributor) }, only: [:index, :new, :create]
  before_action -> { authorize(@contributor) }, only: [:destroy]

  def index
    @records, @pagination_record = scope.paginate(after: params[:after])
  end

  def new
    @form = CreateContributor.new

    render partial: "new"
  end

  def create
    @form = CreateContributor.new(create_params)

    if @form.save
      head :no_content, location: contributors_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteContributor.new(contributor: @contributor, current_user: current_user).call

    head :no_content
  end

  private

  def scope
    query_class = ContributorsQuery

    if @sub.present?
      scope = query_class.new.where_sub(@sub)
    else
      scope = query_class.new.where_global
    end

    scope = query_class.new(scope).filter_by_username(params[:query])
    scope.includes(:user, :approved_by)
  end

  def pundit_user
    UserContext.new(current_user, @sub)
  end

  def set_sub
    @sub = @contributor.present? ? @contributor.sub : Sub.find_by_lower_url(params[:sub])
  end

  def set_contributor
    @contributor = Contributor.find(params[:id])
  end

  def create_params
    attributes = policy(Contributor).permitted_attributes_for_create

    params.require(:create_contributor).permit(attributes).merge(sub: @sub, current_user: current_user)
  end
end
