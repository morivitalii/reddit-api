require "rails_helper"

RSpec.describe Api::Users::Posts::New::WeekController do
  describe ".index", context: :as_signed_in_user do
    it "returns posts objects" do
      user = create(:user)
      create_list(:post, 2, created_by: user)

      get "/api/users/#{user.to_param}/posts/new/week.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/posts/new/week_controller/index/200")
    end
  end
end