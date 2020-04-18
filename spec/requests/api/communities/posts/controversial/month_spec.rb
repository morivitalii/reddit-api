require "rails_helper"

RSpec.describe Api::Communities::Posts::Controversial::MonthController, context: :as_signed_out_user do
  describe ".index" do
    it "returns paginated monthly posts sorted by controversy score" do
      community = create(:community)
      _unrelated_post = create(:created_last_month_post, community: community)
      first_post = create(:created_this_month_post, community: community, controversy_score: 3)
      second_post = create(:created_this_month_post, community: community, controversy_score: 2)
      third_post = create(:created_this_month_post, community: community, controversy_score: 1)

      get "/api/communities/#{community.to_param}/posts/controversial/month.json?after=#{first_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/controversial/day_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, third_post)
    end
  end
end
