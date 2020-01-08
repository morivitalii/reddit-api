require "rails_helper"

RSpec.describe Api::Communities::Posts::Controversial::WeekController do
  describe ".index", context: :as_signed_in_user do
    it "returns posts objects" do
      community = create(:community)
      create_list(:post, 2, community: community)

      get "/api/communities/#{community.to_param}/posts/controversial/week.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/controversial/week_controller/index/200")
    end
  end
end
