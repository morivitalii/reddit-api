require "rails_helper"

RSpec.describe Api::Users::Comments::New::DayController do
  describe ".index", context: :as_signed_in_user do
    it "returns comments objects" do
      create_list(:comment, 2, created_by: context.user)

      get "/api/users/#{context.user.to_param}/comments/new/day.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/comments/new/day_controller/index/200")
    end
  end
end
