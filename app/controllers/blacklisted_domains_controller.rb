# frozen_string_literal: true

class BlacklistedDomainsController < ApplicationController
  before_action :set_sub, only: [:index, :search, :new, :create]
  before_action :set_blacklisted_domain, only: [:destroy]
  before_action -> { authorize(BlacklistedDomain) }, only: [:index, :search, :new, :create]

  def index
    @records, @pagination_record = BlacklistedDomain.where(sub: @sub).paginate(after: params[:after])
  end

  def search
    @records = BlacklistedDomain.where(sub: @sub).search(params[:query]).all

    render "index"
  end

  def new
    @form = CreateBlacklistedDomain.new

    render partial: "new"
  end

  def create
    @form = CreateBlacklistedDomain.new(create_params)

    if @form.save
      head :no_content, location: blacklisted_domains_path(sub: @sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteBlacklistedDomain.new(blacklisted_domain: @blacklisted_domain, current_user: current_user).call

    head :no_content
  end

  private

  def pundit_user
    UserContext.new(current_user, @sub || @blacklisted_domain&.sub)
  end

  def set_sub
    @sub = params[:sub].present? ? Sub.where("lower(url) = ?", params[:sub].downcase).take! : nil
  end

  def set_blacklisted_domain
    @blacklisted_domain = BlacklistedDomain.find(params[:id])
  end

  def create_params
    params.require(:create_blacklisted_domain).permit(:domain).merge(sub: @sub, current_user: current_user)
  end
end
