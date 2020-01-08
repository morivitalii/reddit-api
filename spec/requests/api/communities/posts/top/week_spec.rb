require "rails_helper"

RSpec.describe Api::Communities::Posts::Top::WeekController do
  describe ".index", context: :as_signed_in_user do
    it "returns posts objects" do
      community = create(:community)
      create_list(:post, 2, community: community)

      get "/api/communities/#{community.to_param}/posts/top/week.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/top/week_controller/index/200")
    end
  end
end
