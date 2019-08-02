require "rails_helper"

RSpec.describe BansQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:bans) { [create(:sub_ban, sub: sub)] }

    it "returns sub bans" do
      expected_result = bans
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:bans) { [create(:global_ban)] }

    it "returns global bans" do
      expected_result = bans
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_username" do
    let!(:bans) { create_pair(:ban) }

    it "returns bans if given user username is blank" do
      expected_result = bans
      result = subject.filter_by_username(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns ban where user have a given username" do
      expected_result = [bans.first]
      username = expected_result.first.user.username
      result = subject.filter_by_username(username).all

      expect(result).to eq(expected_result)
    end
  end
end