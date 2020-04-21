require "rails_helper"

RSpec.describe Api::Communities::Posts::Comments::Votes::DownsController, context: :as_signed_in_user do
  describe ".create" do
    it "creates down vote on comment" do
      community = create(:community)
      post = create(:post, community: community)
      comment = create(:comment, post: post)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/votes/downs.json"

      expect(response).to have_http_status(204)
    end
  end

  describe ".destroy" do
    it "deletes down vote on comment" do
      community = create(:community)
      post = create(:post, community: community)
      comment = create(:comment, post: post)

      delete "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/votes/downs.json"

      expect(response).to have_http_status(204)
    end
  end
end
