module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def current_user
      request.env["warden"].user
    end
  end
end
