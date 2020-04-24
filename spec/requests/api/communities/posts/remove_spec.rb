require "rails_helper"

RSpec.describe Api::Communities::Posts::RemoveController, context: :as_moderator_user do
  describe ".update" do
    it "removes post" do
      community = context.community
      post = create(:not_removed_post, community: community)
      params = {
        reason: "Reason"
      }

      put "/api/communities/#{community.to_param}/posts/#{post.to_param}/remove.json", params: params

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/remove_controller/update/200")
    end
  end
end
