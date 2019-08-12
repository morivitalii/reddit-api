# frozen_string_literal: true

class BlacklistedDomainsController < ApplicationController
  before_action :set_sub
  before_action :set_facade
  before_action :set_blacklisted_domain, only: [:destroy]
  before_action -> { authorize(BlacklistedDomain) }, only: [:index, :new, :create]
  before_action -> { authorize(@blacklisted_domain) }, only: [:destroy]

  def index
    @records, @pagination = query.paginate(after: params[:after])
  end

  def new
    @form = CreateBlacklistedDomainForm.new

    render partial: "new"
  end

  def create
    @form = CreateBlacklistedDomainForm.new(create_params)

    if @form.save
      head :no_content, location: sub_blacklisted_domains_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteBlacklistedDomainService.new(@blacklisted_domain).call

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
    @facade = BlacklistedDomainsFacade.new(context)
  end

  def query
    BlacklistedDomainsQuery.new(@sub.blacklisted_domains).search_by_domain(params[:query])
  end

  def set_blacklisted_domain
    @blacklisted_domain = @sub.blacklisted_domains.find(params[:id])
  end

  def create_params
    attributes = policy(BlacklistedDomain).permitted_attributes_for_create

    params.require(:create_blacklisted_domain_form).permit(attributes).merge(sub: @sub)
  end
end
