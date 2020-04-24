require "rails_helper"

RSpec.describe Api::Communities::Posts::SpoilerController, context: :as_moderator_user do
  describe ".create" do
    it "marks post as spoiler" do
      community = context.community
      post = create(:not_spoiler_post, community: community)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/spoiler.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/spoiler_controller/create/200")
    end
  end

  describe ".destroy" do
    it "marks post ad not spoiler" do
      community = context.community
      post = create(:spoiler_post, community: community)

      delete "/api/communities/#{community.to_param}/posts/#{post.to_param}/spoiler.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/spoiler_controller/destroy/200")
    end
  end
end
