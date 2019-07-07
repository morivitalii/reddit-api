# frozen_string_literal: true

class SubBlacklistedDomainsController < BaseSubController
  before_action :set_blacklisted_domain, only: [:confirm, :destroy]
  before_action -> { authorize(@sub, policy_class: SubBlacklistedDomainPolicy) }

  def index
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
    @records = @sub.blacklisted_domains.search(params[:query]).all

    render "index"
  end

  def new
    @form = CreateSubBlacklistedDomain.new

    render partial: "new"
  end

  def create
    @form = CreateSubBlacklistedDomain.new(create_params.merge(sub: @sub, current_user: current_user))

    if @form.save
      head :no_content, location: sub_blacklisted_domains_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    render partial: "confirm"
  end

  def destroy
    DeleteSubBlacklistedDomain.new(blacklisted_domain: @blacklisted_domain, current_user: current_user).call

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
