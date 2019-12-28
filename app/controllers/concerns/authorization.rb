module Authorization
  extend ActiveSupport::Concern

  included do
    private

    rescue_from Pundit::NotAuthorizedError, with: :authorization_error

    def authorization_error
      head :forbidden
    end

    def authorize(policy_class, record = nil)
      super(record, policy_class: policy_class)
    end
  end
end
