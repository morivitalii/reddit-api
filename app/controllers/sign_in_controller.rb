class SignInController < ApiApplicationController
  before_action -> { authorize(:sign_in) }

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

  private

  def pundit_user
    Context.new(current_user, nil)
  end
end
