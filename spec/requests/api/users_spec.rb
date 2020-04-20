require "rails_helper"

RSpec.describe Api::UsersController, context: :as_signed_in_user do
  describe ".show" do
    it "returns user object" do
      user = create(:user)

      get "/api/users/#{user.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users_controller/show/200")
    end
  end

  describe ".update" do
    context "with valid params" do
      it "updates user and returns user object" do
        put "/api/users.json", params: {email: "email@example.com", password: "password"}

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/users_controller/update/200")
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        put "/api/users.json", params: {email: "invalid email", password: ""}

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/users_controller/update/422")
      end
    end
  end
end
