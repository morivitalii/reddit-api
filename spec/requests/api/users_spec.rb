require "rails_helper"

RSpec.describe Api::UsersController do
  describe ".index", context: :as_signed_out_user do
    it "returns paginated users sorted by desc" do
      first_user = create(:user)
      second_user = create(:user)
      third_user = create(:user)

      get "/api/users.json?after=#{third_user.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users_controller/index/200")
      expect(response).to have_sorted_json_collection(second_user, first_user)
    end
  end

  describe ".show", context: :as_signed_out_user do
    it "returns user" do
      user = create(:user)

      get "/api/users/#{user.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users_controller/show/200")
    end
  end

  describe ".update", context: :as_signed_in_user do
    context "with valid params" do
      it "updates user and returns user" do
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
