require "rails_helper"

RSpec.describe ReportsQuery do
  subject { described_class.new }

  describe ".posts" do
    let(:post_reports) { [create(:post_report)] }
    let(:comment_reports) { [create(:comment_report)] }

    it "returns post reports" do
      expected_result = post_reports
      result = subject.posts.all

      expect(result).to eq(expected_result)
    end
  end
  
  describe ".comments" do
    let(:post_reports) { [create(:post_report)] }
    let(:comment_reports) { [create(:comment_report)] }

    it "returns post reports" do
      expected_result = comment_reports
      result = subject.comments.all

      expect(result).to eq(expected_result)
    end
  end
  
  describe ".where_sub" do
    let(:sub) { create(:sub) }
    let(:sub_reports) { [create(:report, sub: sub)] }
    let(:reports) { [create(:report)] }

    it "returns reports where sub is given sub" do
      expected_result = sub_reports
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end
  
  describe ".subs_where_user_moderator" do
    let!(:user) { create(:user) }
    let!(:sub) { create(:sub) }
    let!(:sub_moderator) { create(:sub_moderator, user: user, sub: sub) }
    let!(:sub_reports) { [create(:report, sub: sub)] }
    let!(:reports) { [create(:report)] }

    it "returns reports from subs where user is moderator" do
      expected_result = sub_reports
      result = subject.subs_where_user_moderator(user).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".recent" do
    let!(:reports) { create_list(:report, 3) }

    it "returns recent reports" do
      expected_result = reports[1..-1].reverse
      result = subject.recent(2).all

      expect(result).to eq(expected_result)
    end
  end
end