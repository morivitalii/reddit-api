require "rails_helper"

RSpec.describe ContributorsQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_contributors) { [create(:sub_contributor, sub: sub)] }
    let!(:global_contributors) { [create(:global_contributor)] }

    it "returns sub contributors" do
      expected_result = sub_contributors
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:sub_contributors) { [create(:sub_contributor)] }
    let!(:global_contributors) { [create(:global_contributor)] }

    it "returns global contributors" do
      expected_result = global_contributors
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_username" do
    let!(:contributors) { create_pair(:contributor) }

    it "returns contributors if given user username is blank" do
      expected_result = contributors
      result = subject.filter_by_username(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns contributor where user has a given username" do
      expected_result = [contributors.first]
      username = expected_result.first.user.username
      result = subject.filter_by_username(username).all

      expect(result).to eq(expected_result)
    end
  end
end