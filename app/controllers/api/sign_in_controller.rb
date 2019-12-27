class Api::SignInController < ApiApplicationController
  before_action -> { authorize(nil, policy_class: Api::SignInPolicy) }

  def create
    @form = SignIn.new

    if verify_recaptcha(model: @form, attribute: :username) && request.env["warden"].authenticate!(:password)
      render json: UserSerializer.serialize(current_user), status: :ok
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def unauthenticated
    @form = request.env["warden.options"][:form]

    render json: @form.errors, status: :unprocessable_entity
  end
end
