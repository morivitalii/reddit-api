require "rails_helper"

RSpec.describe ContributorsQuery do
  subject { described_class }

  describe ".with_username" do
    let!(:user) { create(:user) }
    let!(:expected) { create_pair(:contributor, user: user) }
    let!(:others) { create_pair(:contributor) }

    it "returns results filtered by username" do
      result = subject.new.with_username(user.username)

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".search_by_username" do
    it "returns relation if username is blank" do
      query = subject.new

      expected_result = query.relation
      result = query.search_by_username("")

      expect(result).to eq(expected_result)
    end

    it "calls .with_username if username is present" do
      query = subject.new

      expect(query).to receive(:with_username).with(anything)

      query.search_by_username(anything)
    end
  end
end