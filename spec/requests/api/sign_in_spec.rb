require "rails_helper"

RSpec.describe Api::SignInController do
  describe ".create" do
    context "with right credentials" do
      it "signs in user and returns user object" do
        user = create(:user)

        post "/api/sign_in.json", params: {username: user.username, password: user.password}

        expect(response).to have_http_status(200)
        expect(session["warden.user.default.key"]).to eq(user.id)
        expect(response).to match_json_schema("controllers/api/sign_in/create/200", strict: true)
      end
    end

    context "with wrong credentials" do
      it "does not sign in user and returns error messages" do
        post "/api/sign_in.json", params: {username: "username", password: "password"}

        expect(response).to have_http_status(422)
        expect(session["warden.user.default.key"]).to be_nil
        expect(response).to match_json_schema("controllers/api/sign_in/create/422")
      end
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
