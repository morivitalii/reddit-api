require "rails_helper"

RSpec.describe Api::Communities::Posts::TagController, context: :as_moderator_user do
  describe ".update" do
    it "updates post tag" do
      community = context.community
      post = create(:without_tag_post, community: community)

      put "/api/communities/#{community.to_param}/posts/#{post.to_param}/tag.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/tag_controller/update/200")
    end
  end
end
