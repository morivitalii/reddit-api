class Api::ExilesController < ApplicationController
  before_action :set_exile, only: [:show, :destroy]
  before_action -> { authorize(Api::ExilesPolicy) }, only: [:index, :create]
  before_action -> { authorize(Api::ExilesPolicy, @exile) }, only: [:show, :destroy]

  def index
    query = Exile.includes(:user)
    exiles = paginate(
      query,
      attributes: [:id],
      order: :desc,
      limit: 25,
      after: params[:after].present? ? Exile.where(id: params[:after]).take : nil
    )

    render json: ExileSerializer.serialize(exiles)
  end

  def show
    render json: ExileSerializer.serialize(@exile)
  end

  def create
    service = CreateExile.new(create_params)

    if service.call
      render json: ExileSerializer.serialize(service.exile)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    DeleteExile.new(exile: @exile).call

    head :no_content
  end

  private

  def pundit_user
    Context.new(current_user, nil)
  end

  def set_exile
    @exile = Exile.includes(:user).find(params[:id])
  end

  def create_params
    attributes = Api::ExilesPolicy.new(pundit_user).permitted_attributes_for_create
    params.permit(attributes)
  end
end
