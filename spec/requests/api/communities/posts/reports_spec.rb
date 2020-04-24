require "rails_helper"

RSpec.describe Api::Communities::Posts::ReportsController, context: :as_moderator_user do
  describe ".index" do
    it "returns paginated reports sorted by desc" do
      community = context.community
      post = create(:post, community: community)
      first_report = create(:report, reportable: post)
      second_report = create(:report, reportable: post)
      third_report = create(:report, reportable: post)

      get "/api/communities/#{community.to_param}/posts/#{post.to_param}/reports.json?after=#{third_report.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_report, first_report)
      expect(response).to match_json_schema("controllers/api/communities/posts/reports_controller/index/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates report" do
        community = context.community
        post = create(:post, community: community)
        params = {
          text: "Text"
        }

        post "/api/communities/#{community.to_param}/posts/#{post.to_param}/reports.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts/reports_controller/create/200")
      end
    end

    context "with invalid params" do
      it "creates report" do
        community = create(:community)
        post = create(:post, community: community)
        comment = create(:comment, post: post)
        params = {
          text: ""
        }

        post "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/reports.json", params: params

        expect(response).to have_http_status(422)
        expect(response).to match_json_schema("controllers/api/communities/posts/comments/reports_controller/create/422")
      end
    end
  end
end
