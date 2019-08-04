# frozen_string_literal: true

class BlacklistedDomainsController < ApplicationController
  before_action :set_blacklisted_domain, only: [:destroy]
  before_action :set_sub
  before_action -> { authorize(BlacklistedDomain) }, only: [:index, :new, :create]
  before_action -> { authorize(@blacklisted_domain) }, only: [:destroy]

  def index
    @records, @pagination_record = scope.paginate(after: params[:after])
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

  def scope
    query_class = BlacklistedDomainsQuery

    if @sub.present?
      scope = query_class.new.sub(@sub)
    else
      scope = query_class.new.global
    end

    query_class.new(scope).filter_by_domain(params[:query])
  end

  def pundit_user
    Context.new(current_user, @sub)
  end

  def set_sub
    if @blacklisted_domain.present?
      @sub = @blacklisted_domain.sub
    elsif params[:sub].present?
      @sub = SubsQuery.new.where_url(params[:sub]).take!
    end
  end

  def set_blacklisted_domain
    @blacklisted_domain = BlacklistedDomain.find(params[:id])
  end

  def create_params
    attributes = policy(BlacklistedDomain).permitted_attributes_for_create

    params.require(:create_blacklisted_domain).permit(attributes).merge(sub: @sub, current_user: current_user)
  end
end
