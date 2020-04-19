require "rails_helper"

RSpec.describe Api::Communities::Posts::Hot::DayController, context: :as_signed_out_user do
  describe ".index" do
    it "returns paginated daily posts sorted by hot score" do
      community = create(:community)
      _unrelated_post = create(:created_yesterday_post, community: community)
      first_post = create(:created_today_post, community: community, hot_score: 3)
      second_post = create(:created_today_post, community: community, hot_score: 2)
      third_post = create(:created_today_post, community: community, hot_score: 1)

      get "/api/communities/#{community.to_param}/posts/hot/day.json?after=#{first_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/hot/day_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, third_post)
    end
  end
end
