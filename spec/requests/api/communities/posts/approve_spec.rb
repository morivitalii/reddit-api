require "rails_helper"

RSpec.describe Api::Communities::Posts::ApproveController, context: :as_moderator_user do
  describe ".update" do
    it "approves comment" do
      community = context.community
      post = create(:not_approved_post, community: community)

      put "/api/communities/#{community.to_param}/posts/#{post.to_param}/approve.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/approve_controller/update/200")
    end
  end
end
