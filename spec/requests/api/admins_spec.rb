require "rails_helper"

RSpec.describe Api::AdminsController do
  describe ".index", context: :as_signed_out_user do
    it "returns paginated admins sorted by desc" do
      first_admin = create(:admin)
      second_admin = create(:admin)
      third_admin = create(:admin)

      get "/api/admins.json?after=#{third_admin.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/admins_controller/index/200")
      expect(response).to have_sorted_json_collection(second_admin, first_admin)
    end
  end

  describe ".show", context: :as_signed_in_user do
    it "returns admin" do
      admin = create(:admin)

      get "/api/admins/#{admin.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/admins_controller/show/200")
    end
  end

  describe ".create", context: :as_admin_user do
    context "with valid params" do
      it "creates admin" do
        user = create(:user)

        post "/api/admins.json", params: { user_id: user.id }

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/admins_controller/create/200")
      end
    end

    context "with invalid params" do
      it "returns errors" do
        post "/api/admins.json", params: { user_id: "" }

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/admins_controller/create/422")
      end
    end
  end

  describe ".destroy", context: :as_admin_user do
    it "deletes admin" do
      admin = create(:admin)

      delete "/api/admins/#{admin.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end