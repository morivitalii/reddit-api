require "rails_helper"

RSpec.describe Api::Communities::Posts::ExplicitController, context: :as_moderator_user do
  describe ".create" do
    it "marks post as explicit" do
      community = context.community
      post = create(:not_explicit_post, community: community)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/explicit.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/explicit_controller/create/200")
    end
  end

  describe ".destroy" do
    it "marks post ad not explicit" do
      community = context.community
      post = create(:explicit_post, community: community)

      delete "/api/communities/#{community.to_param}/posts/#{post.to_param}/explicit.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/explicit_controller/destroy/200")
    end
  end
end
