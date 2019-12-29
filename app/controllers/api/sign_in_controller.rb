class Api::SignInController < ApiApplicationController
  before_action -> { authorize(Api::SignInPolicy) }

  def create
    service = SignIn.new

    if verify_recaptcha(model: service, attribute: :username) && request.env["warden"].authenticate!(:password)
      render json: UserSerializer.serialize(current_user)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def unauthenticated
    service = request.env["warden.options"][:service]

    render json: service.errors, status: :unprocessable_entity
  end
end
