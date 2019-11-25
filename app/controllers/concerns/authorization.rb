module Authorization
  extend ActiveSupport::Concern

  included do
    private

    rescue_from Pundit::NotAuthorizedError, with: :authorization_error

    def authorization_error
      if request.xhr?
        if user_signed_in?
          @form = SignInForm.new

          render partial: "/sign_in/new", status: :unauthorized
        else
          head :forbidden
        end
      else
        @community = CommunitiesQuery.new.default.take

        render "/authorization_error", status: :forbidden
      end
    end
  end
end
