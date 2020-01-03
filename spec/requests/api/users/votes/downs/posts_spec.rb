require "rails_helper"

RSpec.describe Api::Users::Votes::Downs::PostsController do
  describe ".index", context: :as_signed_in_user do
    it "returns posts objects" do
      create_list(:post_with_down_vote, 2, voted_by: user)

      get "/api/users/#{user.to_param}/votes/downs/posts.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/votes/downs/posts_controller/index/200")
    end
  end
end