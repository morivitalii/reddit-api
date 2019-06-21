# frozen_string_literal: true

class GlobalBlacklistedDomainsController < ApplicationController
  before_action :set_blacklisted_domain, only: [:confirm, :destroy]

  def index
    GlobalBlacklistedDomainsPolicy.authorize!(:index)

    @records = BlacklistedDomain.include(ReverseChronologicalOrder)
                   .global
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? BlacklistedDomain.global.find_by_id(params[:after]) : nil)
                   .limit(PaginationLimits.global_blacklisted_domains + 1)
                   .to_a

    if @records.size > PaginationLimits.global_blacklisted_domains
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    GlobalBlacklistedDomainsPolicy.authorize!(:index)

    @records = BlacklistedDomain.global.search(params[:query]).all

    render "index"
  end

  def new
    GlobalBlacklistedDomainsPolicy.authorize!(:create)

    @form = CreateGlobalBlacklistedDomain.new

    render partial: "new"
  end

  def create
    GlobalBlacklistedDomainsPolicy.authorize!(:create)

    @form = CreateGlobalBlacklistedDomain.new(create_params.merge(current_user: Current.user))

    if @form.save
      head :no_content, location: global_blacklisted_domains_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    GlobalBlacklistedDomainsPolicy.authorize!(:destroy)

    render partial: "confirm"
  end

  def destroy
    GlobalBlacklistedDomainsPolicy.authorize!(:destroy)

    DeleteGlobalBlacklistedDomain.new(blacklisted_domain: @blacklisted_domain, current_user: Current.user).call

    head :no_content
  end

  private

  def set_blacklisted_domain
    @blacklisted_domain = BlacklistedDomain.global.find(params[:id])
  end

  def create_params
    params.require(:create_global_blacklisted_domain).permit(:domain)
  end
end
