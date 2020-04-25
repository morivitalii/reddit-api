require "rails_helper"

RSpec.describe Api::Communities::RulesController, context: :as_moderator_user do
  describe ".index" do
    it "returns paginated rules sorted by asc" do
      community = context.community
      first_rule = create(:rule, community: community)
      second_rule = create(:rule, community: community)
      third_rule = create(:rule, community: community)

      get "/api/communities/#{community.to_param}/rules.json?after=#{first_rule.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_rule, third_rule)
      expect(response).to match_json_schema("controllers/api/communities/rules_controller/index/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates rule" do
        community = context.community
        params = {
          title: "Title",
          description: "Description"
        }

        post "/api/communities/#{community.to_param}/rules.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/rules_controller/create/200")
      end
    end

    context "with invalid params" do
      it "return errors" do
        community = context.community
        params = {
          title: "",
          description: ""
        }

        post "/api/communities/#{community.to_param}/rules.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/rules_controller/create/422")
      end
    end
  end

  describe ".update" do
    context "with valid params" do
      it "updates rule" do
        community = context.community
        rule = create(:rule, community: community)
        params = {
          title: "New title",
          description: "New description"
        }

        put "/api/communities/#{community.to_param}/rules/#{rule.to_param}.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/rules_controller/update/200")
      end
    end

    context "with invalid params" do
      it "does not update rule and return errors" do
        community = context.community
        rule = create(:rule, community: community)
        params = {}

        put "/api/communities/#{community.to_param}/rules/#{rule.to_param}.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/rules_controller/update/422")
      end
    end
  end

  describe ".destroy" do
    it "deletes rule" do
      community = context.community
      rule = create(:rule, community: community)

      delete "/api/communities/#{community.to_param}/rules/#{rule.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end
