require "rails_helper"

RSpec.describe Api::ForgotPasswordController, context: :as_signed_out_user do
  describe ".create" do
    it "sends forgot password email" do
      user = create(:user)

      post "/api/forgot_password.json", params: {email: user.email}

      expect(response).to have_http_status(204)
    end
  end
end
