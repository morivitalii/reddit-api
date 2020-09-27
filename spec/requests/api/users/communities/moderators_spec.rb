require "rails_helper"

RSpec.describe Api::Users::Communities::ModeratorsController do
  describe ".index", context: :as_signed_out_user do
    it "returns paginated communities where user is moderator sorted by asc" do
      user = create(:user)
      first_community_where_user_moderator = create(:community_with_user_moderator, user: user)
      second_community_where_user_moderator = create(:community_with_user_moderator, user: user)
      third_community_where_user_moderator = create(:community_with_user_moderator, user: user)

      get "/api/users/#{user.to_param}/communities/moderators.json?after=#{first_community_where_user_moderator.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/communities/moderators_controller/index/200")
      expect(response).to have_sorted_json_collection(second_community_where_user_moderator, third_community_where_user_moderator)
    end
  end
end
