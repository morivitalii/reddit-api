require "rails_helper"

RSpec.describe Api::Users::Votes::Ups::CommentsController, context: :as_signed_in_user do
  describe ".index" do
    it "returns paginated up voted comments sorted by desc" do
      user = context.user
      first_comment = create(:comment_with_up_vote, voted_by: user)
      second_comment = create(:comment_with_up_vote, voted_by: user)
      third_comment = create(:comment_with_up_vote, voted_by: user)

      get "/api/users/#{user.to_param}/votes/ups/comments.json?after=#{third_comment.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/votes/ups/comments_controller/index/200")
      expect(response).to have_sorted_json_collection(second_comment, first_comment)
    end
  end
end
