require "rails_helper"

RSpec.describe Api::Users::Bookmarks::PostsController, context: :as_signed_in_user do
  describe ".index" do
    it "returns paginated bookmarked posts sorted by desc" do
      user = context.user
      first_post = create(:post_with_bookmark, bookmarked_by: user)
      second_post = create(:post_with_bookmark, bookmarked_by: user)
      third_post = create(:post_with_bookmark, bookmarked_by: user)

      get "/api/users/#{user.to_param}/bookmarks/posts.json?after=#{third_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/bookmarks/posts_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, first_post)
    end
  end
end
