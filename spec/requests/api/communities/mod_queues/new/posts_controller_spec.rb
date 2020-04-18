require "rails_helper"

RSpec.describe Api::Communities::ModQueues::New::PostsController, context: :as_moderator_user do
  describe ".index" do
    it "returns paginated not moderated posts sorted by id desc" do
      community = context.community
      first_post = create(:not_moderated_post, community: community)
      second_post = create(:not_moderated_post, community: community)
      third_post = create(:not_moderated_post, community: community)

      get "/api/communities/#{community.to_param}/mod_queues/new/posts.json?after=#{third_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mod_queues/new/posts_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, first_post)
    end
  end
end
