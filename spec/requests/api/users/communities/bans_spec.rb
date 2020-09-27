require "rails_helper"

RSpec.describe Api::Users::Communities::BansController do
  describe ".index", context: :as_signed_out_user do
    it "returns paginated communities where user is banned sorted by asc" do
      user = create(:user)
      first_community_where_user_banned = create(:community_with_banned_user, user: user)
      second_community_where_user_banned = create(:community_with_banned_user, user: user)
      third_community_where_user_banned = create(:community_with_banned_user, user: user)

      get "/api/users/#{user.to_param}/communities/bans.json?after=#{first_community_where_user_banned.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/communities/bans_controller/index/200")
      expect(response).to have_sorted_json_collection(second_community_where_user_banned, third_community_where_user_banned)
    end
  end
end
