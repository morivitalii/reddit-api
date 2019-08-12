# frozen_string_literal: true

class ContributorsController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action :set_contributor, only: [:destroy]
  before_action -> { authorize(Contributor) }, only: [:index, :new, :create]
  before_action -> { authorize(@contributor) }, only: [:destroy]

  def index
    @records, @pagination = query.paginate(after: params[:after])
  end

  def new
    @form = CreateContributorForm.new

    render partial: "new"
  end

  def create
    @form = CreateContributorForm.new(create_params)

    if @form.save
      head :no_content, location: sub_contributors_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteContributorService.new(@contributor).call

    head :no_content
  end

  private

  def context
    Context.new(current_user, @sub)
  end

  def set_sub
    @sub = SubsQuery.new.with_url(params[:sub_id]).take!
  end

  def set_facade
    @facade = ContributorsFacade.new(context)
  end

  def set_contributor
    @contributor = @sub.contributors.find(params[:id])
  end

  def query
    ContributorsQuery.new(@sub.contributors).search_by_username(params[:query]).includes(:user, :approved_by)
  end

  def create_params
    attributes = policy(Contributor).permitted_attributes_for_create

    params.require(:create_contributor_form).permit(attributes).merge(sub: @sub, approved_by: current_user)
  end
end
