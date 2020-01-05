require "rails_helper"

RSpec.describe Api::Communities::PostsController do
  describe ".show", context: :as_signed_in_user do
    it "returns post object" do
      community = create(:community)
      post = create(:post, community: community)

      get "/api/communities/#{community.to_param}/posts/#{post.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts_controller/show/200")
    end
  end

  describe ".create", context: :as_signed_in_user do
    context "with valid params" do
      it "creates post and returns post object" do
        community = create(:community)

        post "/api/communities/#{community.to_param}/posts.json", params: {
          title: "Title",
          text: "Text",
          explicit: true,
          spoiler: true
        }

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/create/200")
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        community = create(:community)

        post "/api/communities/#{community.to_param}/posts.json", params: {
          title: "",
          text: "",
          file: ""
        }

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/create/422")
      end
    end
  end

  describe ".update", context: :as_signed_in_user do
    context "with valid params" do
      it "updates post and returns post object" do
        community = create(:community)
        post = create(:text_post, community: community, created_by: user)

        put "/api/communities/#{community.to_param}/posts/#{post.to_param}.json", params: {
          text: "Text",
        }

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/update/200")
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        community = create(:community)
        post = create(:text_post, community: community, created_by: user)

        put "/api/communities/#{community.to_param}/posts/#{post.to_param}.json", params: {
          text: ""
        }

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/update/422")
      end
    end
  end
end