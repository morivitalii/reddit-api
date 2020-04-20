require "rails_helper"

RSpec.describe Api::Users::Comments::New::WeekController, context: :as_signed_in_user do
  describe ".index" do
    it "returns paginated weekly comments sorted by new score" do
      user = context.user
      _unrelated_comment = create(:created_last_week_comment, created_by: user)
      first_comment = create(:created_this_week_comment, created_by: user, new_score: 3)
      second_comment = create(:created_this_week_comment, created_by: user, new_score: 2)
      third_comment = create(:created_this_week_comment, created_by: user, new_score: 1)

      get "/api/users/#{user.to_param}/comments/new/week.json?after=#{first_comment.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/users/comments/new/week_controller/index/200")
      expect(response).to have_sorted_json_collection(second_comment, third_comment)
    end
  end
end
