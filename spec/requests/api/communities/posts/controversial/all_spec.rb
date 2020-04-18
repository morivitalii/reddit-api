require "rails_helper"

RSpec.describe Api::Communities::Posts::Controversial::AllController, context: :as_signed_out_user do
  describe ".index" do
    it "returns all paginated posts sorted by controversy score" do
      community = create(:community)
      first_post = create(:created_last_month_post, community: community, controversy_score: 3)
      second_post = create(:created_last_week_post, community: community, controversy_score: 2)
      third_post = create(:created_yesterday_post, community: community, controversy_score: 1)

      get "/api/communities/#{community.to_param}/posts/controversial/all.json?after=#{first_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/controversial/all_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, third_post)
    end
  end
end
