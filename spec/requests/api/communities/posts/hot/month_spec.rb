require "rails_helper"

RSpec.describe Api::Communities::Posts::Hot::MonthController, context: :as_signed_out_user do
  describe ".index" do
    it "returns paginated monthly posts sorted by hot score" do
      community = create(:community)
      _unrelated_post = create(:created_last_month_post, community: community)
      first_post = create(:created_this_month_post, community: community, hot_score: 3)
      second_post = create(:created_this_month_post, community: community, hot_score: 2)
      third_post = create(:created_this_month_post, community: community, hot_score: 1)

      get "/api/communities/#{community.to_param}/posts/hot/month.json?after=#{first_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/hot/month_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, third_post)
    end
  end
end
