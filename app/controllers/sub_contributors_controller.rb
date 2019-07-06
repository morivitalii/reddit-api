# frozen_string_literal: true

class SubContributorsController < BaseSubController
  before_action :set_contributor, only: [:confirm, :destroy]

  def index
    SubContributorsPolicy.authorize!(:index, @sub)

    @records = Contributor.include(ReverseChronologicalOrder)
                   .where(sub: @sub)
                   .includes(:user, :approved_by)
                   .sort_records_reverse_chronologically
                   .records_after(params[:after].present? ? @sub.contributors.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def search
    SubContributorsPolicy.authorize!(:index, @sub)

    @records = @sub.contributors.search(params[:query]).all

    render "index"
  end

  def new
    SubContributorsPolicy.authorize!(:create, @sub)

    @form = CreateSubContributor.new

    render partial: "new"
  end

  def create
    SubContributorsPolicy.authorize!(:create, @sub)

    @form = CreateSubContributor.new(create_params.merge(sub: @sub, current_user: current_user))

    if @form.save
      head :no_content, location: sub_contributors_path(@sub)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    SubContributorsPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubContributorsPolicy.authorize!(:destroy, @sub)

    DeleteSubContributor.new(contributor: @contributor, current_user: current_user).call

    head :no_content
  end

  private

  def set_contributor
    @contributor = @sub.contributors.find(params[:id])
  end

  def create_params
    params.require(:create_sub_contributor).permit(:username)
  end
end
