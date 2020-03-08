require "rails_helper"

RSpec.describe Api::Communities::Posts::Controversial::AllController do
  describe ".index" do
    it "returns posts sorted by controversy score" do
      community = create(:community)
      first_post = create(:post, community: community, controversy_score: 2)
      second_post = create(:post, community: community, controversy_score: 1)

      get "/api/communities/#{community.to_param}/posts/controversial/all.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/controversial/all_controller/index/200")
      expect(response).to have_sorted_json_collection(first_post, second_post)
    end

    it "returns paginated posts" do
      community = create(:community)
      first_post = create(:post, community: community, controversy_score: 3)
      second_post = create(:post, community: community, controversy_score: 2)
      third_post = create(:post, community: community, controversy_score: 1)

      get "/api/communities/#{community.to_param}/posts/controversial/all.json?after=#{first_post.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/controversial/all_controller/index/200")
      expect(response).to have_sorted_json_collection(second_post, third_post)
    end

    context "for signed out user", context: :as_signed_out_user do
      it "returns posts" do
        community = create(:community)
        first_post = create(:post, community: community, controversy_score: 2)
        second_post = create(:post, community: community, controversy_score: 1)

        get "/api/communities/#{community.to_param}/posts/controversial/all.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts/controversial/all_controller/index/200")
        expect(response).to have_sorted_json_collection(first_post, second_post)
      end
    end

    context "for signed in user", context: :as_signed_in_user do
      it "returns posts" do
        community = create(:community)
        first_post = create(:post, community: community, controversy_score: 2)
        second_post = create(:post, community: community, controversy_score: 1)

        get "/api/communities/#{community.to_param}/posts/controversial/all.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts/controversial/all_controller/index/200")
        expect(response).to have_sorted_json_collection(first_post, second_post)
      end
    end

    context "for moderator user", context: :as_moderator_user do
      it "returns posts" do
        first_post = create(:post, community: context.community, controversy_score: 2)
        second_post = create(:post, community: context.community, controversy_score: 1)

        get "/api/communities/#{context.community.to_param}/posts/controversial/all.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts/controversial/all_controller/index/200")
        expect(response).to have_sorted_json_collection(first_post, second_post)
      end
    end

    context "for banned user", context: :as_banned_user do
      it "returns posts" do
        get "/api/communities/#{context.community.to_param}/posts/controversial/all.json"

        expect(response).to have_http_status(403)
      end
    end
  end
end
