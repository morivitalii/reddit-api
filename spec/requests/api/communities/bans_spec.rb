require "rails_helper"

RSpec.describe Api::Communities::BansController, context: :as_moderator_user do
  describe ".index" do
    it "returns paginated bans sorted by desc" do
      community = context.community
      first_ban = create(:ban, source: community)
      second_ban = create(:ban, source: community)
      third_ban = create(:ban, source: community)

      get "/api/communities/#{community.to_param}/bans.json?after=#{third_ban.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_ban, first_ban)
      expect(response).to match_json_schema("controllers/api/communities/bans_controller/index/200")
    end
  end

  describe ".show" do
    it "returns ban" do
      community = context.community
      ban = create(:ban, source: community)

      get "/api/communities/#{community.to_param}/bans/#{ban.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/bans_controller/show/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates ban" do
        community = context.community
        user = create(:user)
        params = {
          user_id: user.id,
          end_at: Time.current.tomorrow
        }

        post "/api/communities/#{community.to_param}/bans.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/bans_controller/create/200")
      end
    end

    context "with invalid params" do
      it "return errors" do
        community = context.community
        params = {
          user_id: ""
        }

        post "/api/communities/#{community.to_param}/bans.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/bans_controller/create/422")
      end
    end
  end

  describe ".update" do
    context "with valid params" do
      it "updates ban" do
        community = context.community
        ban = create(:ban, source: community)
        params = {
            end_at: Time.current.tomorrow
        }

        put "/api/communities/#{community.to_param}/bans/#{ban.to_param}.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/bans_controller/update/200")
      end
    end

    context "with invalid params" do
      it "does not update ban and return errors" do
        community = context.community
        ban = create(:ban, source: community)
        params = {
            end_at: ""
        }

        put "/api/communities/#{community.to_param}/bans/#{ban.to_param}.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/bans_controller/update/422")
      end
    end
  end

  describe ".destroy" do
    it "deletes ban" do
      community = context.community
      ban = create(:ban, source: community)

      delete "/api/communities/#{community.to_param}/bans/#{ban.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end
