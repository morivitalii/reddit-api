require "rails_helper"

RSpec.describe Api::Communities::MutesController, context: :as_moderator_user do
  describe ".index" do
    it "returns mutes sorted by desc" do
      community = context.community
      first_mute = create(:mute, community: community)
      second_mute = create(:mute, community: community)

      get "/api/communities/#{community.to_param}/mutes.json"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_mute, first_mute)
      expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
    end

    it "returns paginated mutes" do
      community = context.community
      first_mute = create(:mute, community: community)
      second_mute = create(:mute, community: community)
      third_mute = create(:mute, community: community)

      get "/api/communities/#{community.to_param}/mutes.json?after=#{third_mute.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
      expect(response).to have_sorted_json_collection(second_mute, first_mute)
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates mute" do
        community = context.community
        user = create(:user)

        post "/api/communities/#{community.to_param}/mutes.json", params: {user_id: user.id, permanent: true}

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/create/200")
      end
    end

    context "with invalid params" do
      it "return errors" do
        community = context.community

        post "/api/communities/#{community.to_param}/mutes.json", params: {user_id: ""}

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/create/422")
      end
    end
  end

  describe ".update" do
    context "with valid params" do
      it "updates mute" do
        community = context.community
        mute = create(:mute, community: community)

        put "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json", params: {permanent: true}

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/update/200")
      end
    end

    context "with invalid params" do
      it "does not update mute and return errors" do
        community = context.community
        mute = create(:mute, community: community)

        put "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json", params: {}

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/update/422")
      end
    end
  end

  describe ".destroy" do
    it "deletes mute" do
      community = context.community
      mute = create(:mute, community: community)

      delete "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end