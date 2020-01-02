require "rails_helper"

RSpec.describe Api::SignUpController do
  describe ".create", context: :as_signed_out_user do
    context "with valid params" do
      it "creates, signs in user and returns user object" do
        post "/api/sign_up.json", params: {username: "username", email: "email@example.com", password: "password"}

        expect(session["warden.user.default.key"]).to_not be_nil
        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/sign_up_controller/create/200")
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        post "/api/sign_up.json", params: {username: "", email: "invalid email", password: ""}

        expect(session["warden.user.default.key"]).to be_nil
        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/sign_up_controller/create/422")
      end
    end
  end
end