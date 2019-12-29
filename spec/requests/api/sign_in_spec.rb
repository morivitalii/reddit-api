require "rails_helper"

RSpec.describe Api::SignInController do
  describe ".create", context: :as_signed_out_user do
    context "with valid params" do
      it "signs in user and returns user object" do
        user = create(:user)

        post "/api/sign_in.json", params: {username: user.username, password: user.password}

        expect(session["warden.user.default.key"]).to eq(user.id)
        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/sign_in/create/200")
      end
    end

    context "with invalid params" do
      it "does not sign in user and returns error messages" do
        post "/api/sign_in.json", params: {username: "username", password: "password"}

        expect(session["warden.user.default.key"]).to be_nil
        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/sign_in/create/422")
      end
    end
  end
end
