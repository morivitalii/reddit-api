class Api::AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :destroy]
  before_action -> { authorize(Api::AdminsPolicy) }, only: [:index, :create]
  before_action -> { authorize(Api::AdminsPolicy, @admin) }, only: [:show, :destroy]

  def index
    query = Admin.includes(:user)
    admins = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Admin.where(id: params[:after]).take : nil
    )

    render json: AdminSerializer.serialize(admins)
  end

  def show
    render json: AdminSerializer.serialize(@admin)
  end

  def create
    service = CreateAdmin.new(create_params)

    if service.call
      render json: AdminSerializer.serialize(service.admin)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteAdmin.new(admin: @admin).call

    head :no_content
  end

  private

  def pundit_user
    Context.new(current_user, nil)
  end

  def set_admin
    @admin = Admin.includes(:user).find(params[:id])
  end

  def create_params
    attributes = Api::AdminsPolicy.new(pundit_user).permitted_attributes_for_create
    params.permit(attributes)
  end
end
