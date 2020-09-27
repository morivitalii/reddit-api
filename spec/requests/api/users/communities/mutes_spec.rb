require "rails_helper"

RSpec.describe Api::Users::Communities::MutesController do
  describe ".index", context: :as_signed_out_user do
    it "returns paginated communities where user is muted sorted by asc" do
      user = create(:user)
      first_community_where_user_muted = create(:community_with_muted_user, user: user)
      second_community_where_user_muted = create(:community_with_muted_user, user: user)
      third_community_where_user_muted = create(:community_with_muted_user, user: user)

      get "/api/users/#{user.to_param}/communities/mutes.json?after=#{first_community_where_user_muted.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/communities/mutes_controller/index/200")
      expect(response).to have_sorted_json_collection(second_community_where_user_muted, third_community_where_user_muted)
    end
  end
end
