require "rails_helper"

RSpec.describe Api::Communities::Posts::BookmarksController, context: :as_signed_in_user do
  describe ".create" do
    it "creates bookmark on post" do
      community = create(:community)
      post = create(:post, community: community)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/bookmarks.json"

      expect(response).to have_http_status(204)
    end
  end

  describe ".destroy" do
    it "deletes bookmark on post" do
      community = create(:community)
      post = create(:post, community: community)

      delete "/api/communities/#{community.to_param}/posts/#{post.to_param}/bookmarks.json"

      expect(response).to have_http_status(204)
    end
  end
end
