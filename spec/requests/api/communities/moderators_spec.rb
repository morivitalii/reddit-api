require "rails_helper"

RSpec.describe Api::Communities::ModeratorsController, context: :as_admin_user do
  describe ".index" do
    it "returns paginated moderators sorted by desc" do
      community = create(:community)
      first_moderator = create(:moderator, community: community)
      second_moderator = create(:moderator, community: community)
      third_moderator = create(:moderator, community: community)

      get "/api/communities/#{community.to_param}/moderators.json?after=#{third_moderator.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_moderator, first_moderator)
      expect(response).to match_json_schema("controllers/api/communities/moderators_controller/index/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates moderator" do
        community = create(:community)
        user = create(:user)
        params = {
          user_id: user.id,
          permanent: true
        }

        post "/api/communities/#{community.to_param}/moderators.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/moderators_controller/create/200")
      end
    end

    context "with invalid params" do
      it "return errors" do
        community = create(:community)
        params = {
          user_id: ""
        }

        post "/api/communities/#{community.to_param}/moderators.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/moderators_controller/create/422")
      end
    end
  end

  describe ".destroy" do
    it "deletes moderator" do
      community = create(:community)
      moderator = create(:moderator, community: community)

      delete "/api/communities/#{community.to_param}/moderators/#{moderator.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end
