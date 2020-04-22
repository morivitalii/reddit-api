require "rails_helper"

RSpec.describe Api::Communities::Posts::Reports::IgnoreController, context: :as_moderator_user do
  describe ".create" do
    it "makes post ignore reports" do
      community = context.community
      post = create(:post, community: community)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/reports/ignore.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/reports/ignore_controller/create/200")
    end
  end

  describe ".destroy" do
    it "makes post do not ignore reports" do
      community = context.community
      post = create(:post, community: community)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/reports/ignore.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/reports/ignore_controller/create/200")
    end
  end
end
