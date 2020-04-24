require "rails_helper"

RSpec.describe Api::Communities::Posts::Comments::RemoveController, context: :as_moderator_user do
  describe ".update" do
    it "removes comment" do
      community = context.community
      post = create(:post, community: community)
      comment = create(:not_removed_comment, post: post)
      params = {
        reason: "Reason"
      }

      put "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/remove.json", params: params

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/comments/remove_controller/update/200")
    end
  end
end
