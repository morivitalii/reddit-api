require "rails_helper"

RSpec.describe Api::Users::Votes::Downs::CommentsController do
  describe ".index", context: :as_signed_in_user do
    it "returns comments objects" do
      create_list(:comment_with_down_vote, 2, created_by: user)

      get "/api/users/#{user.to_param}/votes/downs/comments.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/votes/downs/comments_controller/index/200")
    end
  end
end
