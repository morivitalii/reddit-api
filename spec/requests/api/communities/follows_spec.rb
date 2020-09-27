require "rails_helper"

RSpec.describe Api::Communities::FollowsController, context: :as_signed_in_user do
  describe ".index" do
    it "returns paginated follows sorted by desc" do
      community = create(:community)
      # TODO need refactoring after factories refactoring
      first_follow = create(:follow, followable: community)
      second_follow = create(:follow, followable: community)
      third_follow = create(:follow, followable: community)

      get "/api/communities/#{community.to_param}/follows.json?after=#{third_follow.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_follow, first_follow)
      expect(response).to match_json_schema("controllers/api/communities/follows_controller/index/200")
    end
  end

  describe ".create" do
    it "returns follow" do
      community = create(:community)

      post "/api/communities/#{community.to_param}/follows.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/follows_controller/create/200")
    end
  end

  describe ".destroy" do
    it "returns no content header" do
      community = create(:community_with_user_follower, user: context.user)

      delete "/api/communities/#{community.to_param}/follows.json"

      expect(response).to have_http_status(204)
    end
  end
end
