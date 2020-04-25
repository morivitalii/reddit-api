require "rails_helper"

RSpec.describe Api::Communities::TagsController, context: :as_moderator_user do
  describe ".index" do
    it "returns paginated tags sorted by asc" do
      community = context.community
      first_tag = create(:tag, community: community)
      second_tag = create(:tag, community: community)
      third_tag = create(:tag, community: community)

      get "/api/communities/#{community.to_param}/tags.json?after=#{first_tag.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_tag, third_tag)
      expect(response).to match_json_schema("controllers/api/communities/tags_controller/index/200")
    end
  end

  describe ".show" do
    it "returns tag" do
      community = context.community
      tag = create(:tag, community: community)

      get "/api/communities/#{community.to_param}/tags/#{tag.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/tags_controller/show/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates tag" do
        community = context.community
        params = {
          text: "Text"
        }

        post "/api/communities/#{community.to_param}/tags.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/tags_controller/create/200")
      end
    end

    context "with invalid params" do
      it "return errors" do
        community = context.community
        params = {
          title: "",
          description: ""
        }

        post "/api/communities/#{community.to_param}/tags.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/tags_controller/create/422")
      end
    end
  end

  describe ".update" do
    context "with valid params" do
      it "updates tag" do
        community = context.community
        tag = create(:tag, community: community)
        params = {
          text: "New text"
        }

        put "/api/communities/#{community.to_param}/tags/#{tag.to_param}.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/tags_controller/update/200")
      end
    end

    context "with invalid params" do
      it "does not update tag and return errors" do
        community = context.community
        tag = create(:tag, community: community)
        params = {}

        put "/api/communities/#{community.to_param}/tags/#{tag.to_param}.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/tags_controller/update/422")
      end
    end
  end

  describe ".destroy" do
    it "deletes tag" do
      community = context.community
      tag = create(:tag, community: community)

      delete "/api/communities/#{community.to_param}/tags/#{tag.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end
