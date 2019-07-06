# frozen_string_literal: true

class SubPagesController < BaseSubController
  before_action :set_page, only: [:show, :edit, :update, :confirm, :destroy]

  def index
    @records = Page.include(ChronologicalOrder)
                   .where(sub: @sub)
                   .sort_records_chronologically
                   .records_after(params[:after].present? ? @sub.pages.find_by_id(params[:after]) : nil)
                   .limit(51)
                   .to_a

    if @records.size > 50
      @records.delete_at(-1)
      @after_record = @records.last
    end
  end

  def show
  end

  def new
    SubPagesPolicy.authorize!(:create, @sub)

    @form = CreateSubPage.new
  end

  def edit
    SubPagesPolicy.authorize!(:update, @sub)

    @form = UpdateSubPage.new(
      title: @page.title,
      text: @page.text
    )
  end

  def create
    SubPagesPolicy.authorize!(:create, @sub)

    @form = CreateSubPage.new(create_params.merge(sub: @sub, current_user: current_user))

    if @form.save
      head :no_content, location: sub_page_path(@sub, @form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def update
    SubPagesPolicy.authorize!(:update, @sub)

    @form = UpdateSubPage.new(update_params.merge(page: @page, current_user: current_user))

    if @form.save
      head :no_content, location: sub_page_path(@sub, @form.page)
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def confirm
    SubPagesPolicy.authorize!(:destroy, @sub)

    render partial: "confirm"
  end

  def destroy
    SubPagesPolicy.authorize!(:destroy, @sub)

    DeleteSubPage.new(page: @page, current_user: current_user).call

    head :no_content
  end

  private

  def set_page
    @page = @sub.pages.find(params[:id])
  end

  def create_params
    params.require(:create_sub_page).permit(:title, :text)
  end

  def update_params
    params.require(:update_sub_page).permit(:title, :text)
  end
end
