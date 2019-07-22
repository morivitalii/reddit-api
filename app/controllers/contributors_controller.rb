# frozen_string_literal: true

class ContributorsController < ApplicationController
  before_action :set_sub, only: [:index, :search, :new, :create]
  before_action :set_contributor, only: [:destroy]
  before_action -> { authorize(Contributor) }

  def index
    @records = Contributor.where(sub: @sub)
                   .includes(:user, :approved_by)
                   .reverse_chronologically(after)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    @records = Contributor.where(sub: @sub).search(params[:query]).all

    render "index"
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

  def pundit_user
    UserContext.new(current_user, @sub || @contributor&.sub)
  end

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end

  def set_contributor
    @contributor = Contributor.find(params[:id])
  end

  def create_params
    params.require(:create_contributor).permit(:username).merge(sub: @sub, current_user: current_user)
  end

  def after
    params[:after].present? ? Contributor.find_by_id(params[:after]) : nil
  end
end
