require "rails_helper"

RSpec.describe Api::Communities::PostsController, context: :as_signed_in_user do
  describe ".show" do
    it "returns post object" do
      community = create(:community)
      post = create(:post, community: community)

      get "/api/communities/#{community.to_param}/posts/#{post.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts_controller/show/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates post and returns post object" do
        community = create(:community)
        params = {
          title: "Title",
          text: "Text",
          spoiler: false,
          explicit: false
        }

        post "/api/communities/#{community.to_param}/posts.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/create/200")
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        community = create(:community)
        params = {
          title: "",
          text: "",
          spoiler: false,
          explicit: false
        }

        post "/api/communities/#{community.to_param}/posts.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/create/422")
      end
    end
  end

  describe ".update" do
    context "with valid params" do
      it "updates post and returns post object" do
        community = create(:community)
        post = create(:text_post, community: community, created_by: context.user)
        params = {
          text: "Text"
        }

        put "/api/communities/#{community.to_param}/posts/#{post.to_param}.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/update/200")
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        community = create(:community)
        post = create(:text_post, community: community, created_by: context.user)
        params = {
          text: ""
        }

        put "/api/communities/#{community.to_param}/posts/#{post.to_param}.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/posts_controller/update/422")
      end
    end
  end
end
