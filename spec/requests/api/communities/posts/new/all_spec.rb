require "rails_helper"

RSpec.describe Api::Communities::Posts::New::AllController, context: :as_signed_out_user do
  describe ".index" do
    it "returns paginated posts sorted by new score" do
      community = create(:community)
      first_post = create(:created_last_month_post, community: community, new_score: 3)
      second_post = create(:created_last_week_post, community: community, new_score: 2)
      third_post = create(:created_yesterday_post, community: community, new_score: 1)

      get "/api/communities/#{community.to_param}/posts/new/all.json?after=#{first_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/new/all_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, third_post)
    end
  end
end
