require "rails_helper"

RSpec.describe Api::Communities::ModQueues::New::CommentsController, context: :as_moderator_user do
  describe ".index" do
    it "returns paginated not moderated comments sorted by id desc" do
      community = context.community
      first_comment = create(:not_moderated_comment, community: community)
      second_comment = create(:not_moderated_comment, community: community)
      third_comment = create(:not_moderated_comment, community: community)

      get "/api/communities/#{community.to_param}/mod_queues/new/comments.json?after=#{third_comment.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mod_queues/new/comments_controller/index/200")
      expect(response).to have_sorted_json_collection(second_comment, first_comment)
    end
  end
end
