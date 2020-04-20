require "rails_helper"

RSpec.describe Api::Communities::FollowController, context: :as_signed_in_user do
  describe ".create" do
    it "returns follow object" do
      community = create(:community)

      post "/api/communities/#{community.to_param}/follow.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/follow_controller/create/200")
    end
  end

  describe ".destroy" do
    it "returns no content header" do
      community = create(:community_with_user_follower, user: context.user)

      delete "/api/communities/#{community.to_param}/follow.json"

      expect(response).to have_http_status(204)
    end
  end
end
