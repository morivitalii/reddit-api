# frozen_string_literal: true

class SubBlacklistedDomainsController < BaseSubController
  before_action :set_blacklisted_domain, only: [:confirm, :destroy]

  def index
    SubBlacklistedDomainsPolicy.authorize!(:index, @sub)

    @records = BlacklistedDomain.include(ReverseChronologicalOrder)
                   .where(sub: @sub)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @sub.blacklisted_domains.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    SubBlacklistedDomainsPolicy.authorize!(:index, @sub)

    @records = @sub.blacklisted_domains.search(params[:query]).all

    render "index"
  end

  def new
    SubBlacklistedDomainsPolicy.authorize!(:create, @sub)

    @form = CreateSubBlacklistedDomain.new

    render partial: "new"
  end

  def create
    SubBlacklistedDomainsPolicy.authorize!(:create, @sub)

    @form = CreateSubBlacklistedDomain.new(create_params.merge(sub: @sub, current_user: Current.user))

    if @form.save
      head :no_content, location: sub_blacklisted_domains_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    SubBlacklistedDomainsPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubBlacklistedDomainsPolicy.authorize!(:destroy, @sub)

    DeleteSubBlacklistedDomain.new(blacklisted_domain: @blacklisted_domain, current_user: Current.user).call

    head :no_content
  end

  private

  def set_blacklisted_domain
    @blacklisted_domain = @sub.blacklisted_domains.find(params[:id])
  end

  def create_params
    params.require(:create_sub_blacklisted_domain).permit(:domain)
  end
end
