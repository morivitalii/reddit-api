require "rails_helper"

RSpec.describe PostsQuery do
  subject { described_class }

  describe ".not_moderated" do
    let!(:expected) { create_pair(:post, :not_moderated) }
    let!(:others) { create_pair(:post, :moderated) }

    it "returns not moderated posts" do
      result = subject.new.not_moderated

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".reported" do
    it "returns posts that have reports" do
      posts_without_reports = create_pair(:post)
      posts_with_reports = create_pair(:post_with_reports, reports_count: 1)

      result = subject.new.reported

      expect(result).to contain_exactly(*posts_with_reports)
    end
  end

  describe ".created_after" do
    let!(:datetime) { Time.current }
    let!(:expected) { create_pair(:post, created_at: datetime + 1.hour) }
    let!(:others) { create_pair(:post, created_at: datetime - 1.hour) }

    it "returns results created after given datetime" do
      result = subject.new.created_after(datetime)

      expect(result).to eq(expected)
    end
  end

  describe ".search_created_after" do
    it "returns relation if datetime is blank" do
      query = subject.new
      expected_result = query.relation
      result = query.search_created_after(nil)
      expect(result).to eq(expected_result)
    end

    it "calls .created_after if datetime is present" do
      query = subject.new
      expect(query).to receive(:created_after).with(anything)

      query.search_created_after(anything)
    end
  end
end