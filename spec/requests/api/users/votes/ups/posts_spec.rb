require "rails_helper"

RSpec.describe Api::Users::Votes::Ups::PostsController, context: :as_signed_in_user do
  describe ".index" do
    it "returns paginated up voted posts sorted by desc" do
      user = context.user
      first_post = create(:post_with_up_vote, voted_by: user)
      second_post = create(:post_with_up_vote, voted_by: user)
      third_post = create(:post_with_up_vote, voted_by: user)

      get "/api/users/#{user.to_param}/votes/ups/posts.json?after=#{third_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/votes/ups/posts_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, first_post)
    end
  end
end
