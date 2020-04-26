require "rails_helper"

RSpec.describe Api::Communities::Posts::Comments::ReportsController, context: :as_moderator_user do
  describe ".index" do
    it "returns paginated reports sorted by desc" do
      community = context.community
      post = create(:post, community: community)
      comment = create(:comment, community: community, post: post)
      first_report = create(:report, reportable: comment)
      second_report = create(:report, reportable: comment)
      third_report = create(:report, reportable: comment)

      get "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/reports.json?after=#{third_report.to_param}"

      expect(response).to have_http_status(200)
      expect(response).to have_sorted_json_collection(second_report, first_report)
      expect(response).to match_json_schema("controllers/api/communities/posts/comments/reports_controller/index/200")
    end
  end

  describe ".show" do
    it "returns report" do
      community = context.community
      post = create(:post, community: community)
      comment = create(:comment, post: post)
      report = create(:report, reportable: comment)

      get "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/reports/#{report.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/communities/posts/comments/reports_controller/show/200")
    end
  end

  describe ".create" do
    context "with valid params" do
      it "creates report" do
        community = context.community
        post = create(:post, community: community)
        comment = create(:comment, post: post)
        params = {
          text: "Text"
        }

        post "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/reports.json", params: params

        expect(response).to have_http_status(200)
        expect(response).to match_json_schema("controllers/api/communities/posts/comments/reports_controller/create/200")
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

  describe ".destroy" do
    it "deletes report" do
      community = context.community
      post = create(:post, community: community)
      comment = create(:comment, post: post)
      report = create(:report, reportable: comment)

      delete "/api/communities/#{community.to_param}/posts/#{post.to_param}/comments/#{comment.to_param}/reports/#{report.to_param}.json"

      expect(response).to have_http_status(204)
    end
  end
end
