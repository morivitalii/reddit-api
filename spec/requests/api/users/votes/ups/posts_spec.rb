require "rails_helper"

RSpec.describe Api::Users::Votes::Ups::PostsController do
  describe ".index", context: :as_signed_in_user do
    it "returns posts objects" do
      create_list(:post_with_up_vote, 2, voted_by: user)

      get "/api/users/#{user.to_param}/votes/ups/posts.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/votes/ups/posts_controller/index/200")
    end
  end
end