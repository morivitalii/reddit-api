require "rails_helper"

RSpec.describe Api::Users::Comments::Top::AllController, context: :as_signed_in_user do
  describe ".index" do
    it "returns paginated comments sorted by top score" do
      user = context.user
      first_comment = create(:created_last_month_comment, created_by: user, top_score: 3)
      second_comment = create(:created_last_week_comment, created_by: user, top_score: 2)
      third_comment = create(:created_yesterday_comment, created_by: user, top_score: 1)

      get "/api/users/#{user.to_param}/comments/top/all.json?after=#{first_comment.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/comments/top/all_controller/index/200")
      expect(response).to have_sorted_json_collection(second_comment, third_comment)
    end
  end
end
