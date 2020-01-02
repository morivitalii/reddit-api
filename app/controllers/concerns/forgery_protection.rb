module ForgeryProtection
  extend ActiveSupport::Concern

  included do
    after_action :set_csrf_cookie

    private

    def set_csrf_cookie
      cookies["X-CSRF-Token"] = form_authenticity_token
    end
  end
end
