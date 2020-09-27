require "rails_helper"

RSpec.describe Api::Users::Communities::FollowsController do
  describe ".index", context: :as_signed_out_user do
    it "returns paginated communities where user is follower sorted by asc" do
      user = create(:user)
      first_community_where_user_follower = create(:community_with_user_follower, user: user)
      second_community_where_user_follower = create(:community_with_user_follower, user: user)
      third_community_where_user_follower = create(:community_with_user_follower, user: user)

      get "/api/users/#{user.to_param}/communities/follows.json?after=#{first_community_where_user_follower.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/communities/follows_controller/index/200")
      expect(response).to have_sorted_json_collection(second_community_where_user_follower, third_community_where_user_follower)
    end
  end
end
