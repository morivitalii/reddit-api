require "rails_helper"

RSpec.describe Api::Users::Votes::CommentsController do
  describe ".index", context: :as_signed_in_user do
    it "returns comments objects" do
      create_list(:comment_with_vote, 2, voted_by: context.user)

      get "/api/users/#{context.user.to_param}/votes/comments.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/votes/comments_controller/index/200")
    end
  end
end
