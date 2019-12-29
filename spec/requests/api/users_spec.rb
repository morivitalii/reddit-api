require "rails_helper"

RSpec.describe Api::UsersController do
  describe ".update" do
    context "with valid params" do
      it "updates user" do
        user = create(:user)
        login_as(user)

        put "/api/users.json", params: {email: "email@example.com", password: "password"}

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/users/update/200")
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        user = create(:user)
        login_as(user)

        put "/api/users.json", params: {email: "invalid email", password: ""}

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/users/update/422")
      end
    end
  end
end