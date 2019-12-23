module Authorization
  extend ActiveSupport::Concern

  included do
    private

    rescue_from Pundit::NotAuthorizedError, with: :authorization_error

    def authorization_error
      head :forbidden
    end
  end
end
