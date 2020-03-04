module Authorization
  extend ActiveSupport::Concern

  included do
    private

    rescue_from Pundit::NotAuthorizedError, with: :authorization_error

    def authorization_error
      if current_user.present?
        head :forbidden
      else
        head :unauthorized
      end
    end

    def authorize(policy_class, record = nil)
      super(record, policy_class: policy_class)
    end

    def pundit_user
      raise StandardError.new("pundit_user method is not defined")
    end
  end
end
