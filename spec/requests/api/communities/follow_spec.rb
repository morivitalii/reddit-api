require "rails_helper"

RSpec.describe Api::Communities::FollowController do
  describe ".create" do
    context "as signed out user", context: :as_signed_out_user do
      it "returns unauthorized header" do
        community = create(:community)

        post "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(401)
      end
    end

    context "as signed in user", context: :as_signed_in_user do
      it "returns follow object" do
        community = create(:community)

        post "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/follow_controller/create/200")
      end
    end

    context "as moderator user", context: :as_moderator_user do
      it "returns follow object" do
        community = context.community

        post "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/follow_controller/create/200")
      end
    end

    context "as banned user", context: :as_banned_user do
      it "returns follow object" do
        community = user_context.community

        post "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/follow_controller/create/200")
      end
    end
  end

  describe ".destroy" do
    context "as signed out user", context: :as_signed_out_user do
      it "returns unauthorized header" do
        community = create(:community)

        delete "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(401)
      end
    end

    context "as signed in user", context: :as_signed_in_user do
      it "returns no content header" do
        community = create(:community_with_user_follower, user: context.user)

        delete "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(204)
      end
    end

    context "as moderator user", context: :as_moderator_user do
      it "returns no content header" do
        community = create(:community_with_user_follower, user: context.user)

        delete "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(204)
      end
    end

    context "as banned user", context: :as_banned_user do
      it "returns no content header" do
        community = create(:community_with_user_follower, user: user_context.user)

        delete "/api/communities/#{community.to_param}/follow.json"

        expect(response).to have_http_status(204)
      end
    end
  end
end