require "rails_helper"

RSpec.describe Api::Communities::ModQueues::Reports::CommentsController, context: :as_moderator_user do
  describe ".index" do
    it "returns not moderated comments sorted by id desc" do
      community = context.community
      first_comment = create(:comment_with_reports, community: community)
      second_comment = create(:comment_with_reports, community: community)

      get "/api/communities/#{community.to_param}/mod_queues/reports/comments.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mod_queues/reports/comments_controller/index/200")
      expect(response).to have_sorted_json_collection(second_comment, first_comment)
    end

    it "returns paginated not moderated comments" do
      community = context.community
      first_comment = create(:comment_with_reports, community: community)
      second_comment = create(:comment_with_reports, community: community)
      third_comment = create(:comment_with_reports, community: community)

      get "/api/communities/#{community.to_param}/mod_queues/reports/comments.json?after=#{third_comment.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mod_queues/reports/comments_controller/index/200")
      expect(response).to have_sorted_json_collection(second_comment, first_comment)
    end
  end
end
