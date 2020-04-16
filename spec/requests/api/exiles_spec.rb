require "rails_helper"

RSpec.describe Api::ExilesController, context: :as_admin_user do
  describe ".index" do
    it "returns exiles sorted by desc" do
      first_exile = create(:exile)
      second_exile = create(:exile)

      get "/api/exiles.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/exiles_controller/index/200")
      expect(response).to have_sorted_json_collection(second_exile, first_exile)
    end

    it "returns paginated exiles" do
      first_exile = create(:exile)
      second_exile = create(:exile)
      third_exile = create(:exile)

      get "/api/exiles.json?after=#{third_exile.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/exiles_controller/index/200")
      expect(response).to have_sorted_json_collection(second_exile, first_exile)
    end
  end

  describe ".show" do
    it "returns exile" do
      exile = create(:exile)

      get "/api/exiles/#{exile.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/exiles_controller/show/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates exile" do
        user = create(:user)

        post "/api/exiles.json", params: { user_id: user.id }

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/exiles_controller/create/200")
      end
    end

    context "with invalid params" do
      it "returns errors" do
        post "/api/exiles.json", params: { user_id: "" }

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/exiles_controller/create/422")
      end
    end
  end

  describe ".destroy" do
    it "deletes exile" do
      exile = create(:exile)

      delete "/api/exiles/#{exile.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end