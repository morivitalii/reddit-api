require "rails_helper"

RSpec.describe Api::Communities::MutesController do
  describe ".index" do
    it "returns mutes sorted by desc" do
      community = create(:community)
      first_mute = create(:mute, community: community)
      second_mute = create(:mute, community: community)

      get "/api/communities/#{community.to_param}/mutes.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
      expect(response).to have_sorted_json_collection(second_mute, first_mute)
    end

    it "returns paginated mutes" do
      community = create(:community)
      first_mute = create(:mute, community: community)
      second_mute = create(:mute, community: community)
      third_mute = create(:mute, community: community)

      get "/api/communities/#{community.to_param}/mutes.json?after=#{third_mute.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
      expect(response).to have_sorted_json_collection(second_mute, first_mute)
    end

    context "as signed out user", context: :as_signed_out_user do
      it "returns mutes" do
        community = create(:community)
        create_list(:mute, 2, community: community)

        get "/api/communities/#{community.to_param}/mutes.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
      end
    end

    context "as signed in user", context: :as_signed_in_user do
      it "returns mutes" do
        community = create(:community)
        create_list(:mute, 2, community: community)

        get "/api/communities/#{community.to_param}/mutes.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
      end
    end

    context "as moderator user", context: :as_moderator_user do
      it "returns mutes" do
        create_list(:mute, 2, community: context.community)

        get "/api/communities/#{context.community.to_param}/mutes.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
      end
    end

    context "as muted user", context: :as_muted_user do
      it "returns mutes" do
        create_list(:mute, 2, community: context.community)

        get "/api/communities/#{context.community.to_param}/mutes.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/mutes_controller/index/200")
      end
    end

    context "as banned user", context: :as_banned_user do
      it "returns forbidden header" do
        create_list(:mute, 2, community: context.community)

        get "/api/communities/#{context.community.to_param}/mutes.json"

        expect(response).to have_http_status(403)
      end
    end
  end

  describe ".create" do
    context "as signed out user", context: :as_signed_out_user do
      context "with valid params" do
        it "returns unauthorized header" do
          community = create(:community)
          user = create(:user)

          post "/api/communities/#{community.to_param}/mutes.json", params: {username: user.username, permanent: true}

          expect(response).to have_http_status(401)
        end
      end

      context "with invalid params" do
        it "returns unauthorized header" do
          community = create(:community)

          post "/api/communities/#{community.to_param}/mutes.json", params: {}

          expect(response).to have_http_status(401)
        end
      end
    end

    context "as signed in user", context: :as_signed_in_user do
      context "with valid params" do
        it "returns forbidden header" do
          community = create(:community)
          user = create(:user)

          post "/api/communities/#{community.to_param}/mutes.json", params: {username: user.username, permanent: true}

          expect(response).to have_http_status(403)
        end
      end

      context "with invalid params" do
        it "returns forbidden header" do
          community = create(:community)

          post "/api/communities/#{community.to_param}/mutes.json", params: {username: ""}

          expect(response).to have_http_status(403)
        end
      end
    end

    context "as moderator user", context: :as_moderator_user do
      context "with valid params" do
        it "creates mute" do
          user = create(:user)

          post "/api/communities/#{context.community.to_param}/mutes.json", params: {username: user.username, permanent: true}

          expect(response).to have_http_status(200)
          expect(response).to match_json_schema("controllers/api/communities/mutes_controller/create/200")
        end
      end

      context "with invalid params" do
        it "does not create mute and return errors" do
          post "/api/communities/#{context.community.to_param}/mutes.json", params: {username: ""}

          expect(response).to have_http_status(422)
          expect(response).to match_json_schema("controllers/api/communities/mutes_controller/create/422")
        end
      end
    end

    context "as muted user", context: :as_muted_user do
      context "with valid params" do
        it "returns forbidden header" do
          user = create(:user)

          post "/api/communities/#{context.community.to_param}/mutes.json", params: {username: user.username, permanent: true}

          expect(response).to have_http_status(403)
        end
      end

      context "with invalid params" do
        it "returns forbidden header" do
          post "/api/communities/#{context.community.to_param}/mutes.json", params: {username: ""}

          expect(response).to have_http_status(403)
        end
      end
    end

    context "as banned user", context: :as_banned_user do
      context "with valid params" do
        it "returns forbidden header" do
          user = create(:user)

          post "/api/communities/#{context.community.to_param}/mutes.json", params: {username: user.username, permanent: true}

          expect(response).to have_http_status(403)
        end
      end

      context "with invalid params" do
        it "returns forbidden header" do
          post "/api/communities/#{context.community.to_param}/mutes.json", params: {username: ""}

          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe ".update" do
    context "as signed out user", context: :as_signed_out_user do
      context "with valid params" do
        it "returns unauthorized header" do
          community = create(:community)
          mute = create(:mute, community: community)

          put "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json", params: {permanent: true}

          expect(response).to have_http_status(401)
        end
      end

      context "with invalid params" do
        it "returns unauthorized header" do
          community = create(:community)
          mute = create(:mute, community: community)

          put "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json", params: {}

          expect(response).to have_http_status(401)
        end
      end
    end

    context "as signed in user", context: :as_signed_in_user do
      context "with valid params" do
        it "returns forbidden header" do
          community = create(:community)
          mute = create(:mute, community: community)

          put "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json", params: {permanent: true}

          expect(response).to have_http_status(403)
        end
      end

      context "with invalid params" do
        it "returns forbidden header" do
          community = create(:community)
          mute = create(:mute, community: community)

          put "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json", params: {}

          expect(response).to have_http_status(403)
        end
      end
    end

    context "as moderator user", context: :as_moderator_user do
      context "with valid params" do
        it "updates mute" do
          mute = create(:mute, community: context.community)

          put "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json", params: {permanent: true}

          expect(response).to have_http_status(200)
          expect(response).to match_json_schema("controllers/api/communities/mutes_controller/update/200")
        end
      end

      context "with invalid params" do
        it "does not update mute and return errors" do
          mute = create(:mute, community: context.community)

          put "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json", params: {}

          expect(response).to have_http_status(422)
          expect(response).to match_json_schema("controllers/api/communities/mutes_controller/update/422")
        end
      end
    end

    context "as muted user", context: :as_muted_user do
      context "with valid params" do
        it "returns forbidden header" do
          mute = create(:mute, community: context.community)

          put "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json", params: {permanent: true}

          expect(response).to have_http_status(403)
        end
      end

      context "with invalid params" do
        it "returns forbidden header" do
          mute = create(:mute, community: context.community)

          put "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json", params: {}

          expect(response).to have_http_status(403)
        end
      end
    end

    context "as banned user", context: :as_banned_user do
      context "with valid params" do
        it "returns forbidden header" do
          mute = create(:mute, community: context.community)

          put "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json", params: {permanent: true}

          expect(response).to have_http_status(403)
        end
      end

      context "with invalid params" do
        it "returns forbidden header" do
          mute = create(:mute, community: context.community)

          put "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json", params: {}

          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe ".destroy" do
    context "as signed out user", context: :as_signed_out_user do
      it "returns unauthorized header" do
        community = create(:community)
        mute = create(:mute, community: community)

        delete "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json"

        expect(response).to have_http_status(401)
      end
    end

    context "as signed in user", context: :as_signed_in_user do
      it "returns forbidden header" do
        community = create(:community)
        mute = create(:mute, community: community)

        delete "/api/communities/#{community.to_param}/mutes/#{mute.to_param}.json"

        expect(response).to have_http_status(403)
      end
    end

    context "as moderator user", context: :as_moderator_user do
      it "deletes mute" do
        mute = create(:mute, community: context.community)

        delete "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json"

        expect(response).to have_http_status(204)
      end
    end

    context "as muted user", context: :as_muted_user do
      it "returns forbidden header" do
        mute = create(:mute, community: context.community)

        delete "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json"

        expect(response).to have_http_status(403)
      end
    end

    context "as banned user", context: :as_banned_user do
      it "returns forbidden header" do
        mute = create(:mute, community: context.community)

        delete "/api/communities/#{context.community.to_param}/mutes/#{mute.to_param}.json"

        expect(response).to have_http_status(403)
      end
    end
  end
end