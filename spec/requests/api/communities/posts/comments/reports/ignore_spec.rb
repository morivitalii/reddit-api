require "rails_helper"

RSpec.describe Api::Communities::Posts::Comments::Reports::IgnoreController, context: :as_moderator_user do
  describe ".create" do
    it "makes comment ignore reports" do
      community = context.community
      post = create(:post, community: community)
      comment = create(:ignore_reports_comment, post: post)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/reports/ignore.json"

      expect(response).to have_http_status(204)
    end
  end

  describe ".destroy" do
    it "makes comment do not ignore reports" do
      community = context.community
      post = create(:post, community: community)
      comment = create(:not_ignore_reports_comment, post: post)

      post "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/reports/ignore.json"

      expect(response).to have_http_status(204)
    end
  end
end
