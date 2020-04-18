require "rails_helper"

RSpec.describe Api::Communities::ModQueues::Reports::PostsController, context: :as_moderator_user do
  describe ".index" do
    it "returns not moderated posts sorted by id desc" do
      community = context.community
      first_post = create(:post_with_reports, community: community)
      second_post = create(:post_with_reports, community: community)

      get "/api/communities/#{community.to_param}/mod_queues/reports/posts.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mod_queues/reports/posts_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, first_post)
    end

    it "returns paginated not moderated posts" do
      community = context.community
      first_post = create(:post_with_reports, community: community)
      second_post = create(:post_with_reports, community: community)
      third_post = create(:post_with_reports, community: community)

      get "/api/communities/#{community.to_param}/mod_queues/reports/posts.json?after=#{third_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mod_queues/reports/posts_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, first_post)
    end
  end
end
