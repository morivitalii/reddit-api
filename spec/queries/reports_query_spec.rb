require "rails_helper"

RSpec.describe ReportsQuery do
  subject { described_class }

  describe ".search_by_sub" do
    let!(:sub) { create(:sub) }
    let!(:expected) { create_pair(:report, sub: sub) }
    let!(:others) { create_pair(:report) }

    it "returns relation if sub is blank" do
      query = subject.new

      expected_result = query.relation
      result = query.search_by_sub(nil)

      expect(result).to eq(expected_result)
    end

    it "returns results filtered by sub if sub is present" do
      result = subject.new.search_by_sub(sub)

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".in_subs_moderated_by_user" do
    let!(:user) { create(:user) }
    let!(:sub) { create(:sub) }
    let!(:moderator) { create(:moderator, sub: sub, user: user) }
    let!(:expected) { create_pair(:report, sub: sub) }
    let!(:others) { create_pair(:report) }

    it "returns results filtered by subs where user moderator" do
      result = subject.new.in_subs_moderated_by_user(user)

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".posts_reports" do
    let!(:expected) { create_pair(:post_report) }
    let!(:others) { create_pair(:comment_report) }

    it "returns posts reports" do
      result = subject.new.posts_reports

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".comments_reports" do
    let!(:expected) { create_pair(:comment_report) }
    let!(:others) { create_pair(:post_report) }

    it "returns posts reports" do
      result = subject.new.comments_reports

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".recent" do
    let!(:reports) { create_list(:report, 3) }

    it "returns recent reports" do
      expected_result = reports[1..-1].reverse
      result = subject.new.recent(2)

      expect(result).to eq(expected_result)
    end
  end
end