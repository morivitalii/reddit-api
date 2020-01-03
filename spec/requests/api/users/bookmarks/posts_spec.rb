require "rails_helper"

RSpec.describe Api::Users::Bookmarks::PostsController do
  describe ".index", context: :as_signed_in_user do
    it "returns posts objects" do
      create_list(:post_with_bookmark, 2, bookmarked_by: user)

      get "/api/users/#{user.to_param}/bookmarks/posts.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/bookmarks/posts_controller/index/200")
    end
  end
end