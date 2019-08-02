require "rails_helper"

RSpec.describe BansQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:global_bans) { [create(:global_ban)] }
    let!(:sub_bans) { [create(:sub_ban, sub: sub)] }

    it "returns global bans when sub is absent" do
      result = subject.where_sub(nil).all

      expect(result).to eq(global_bans)
    end

    it "returns sub bans when sub is present" do
      result = subject.where_sub(sub).all

      expect(result).to eq(sub_bans)
    end
  end

  describe ".where_username" do
    let!(:bans) { create_pair(:ban) }

    it "returns bans if given user username is blank" do
      result = subject.where_username(nil).all

      expect(result).to eq(bans)
    end

    it "returns ban where user have a given username" do
      expected_bans = [bans.first]
      username = expected_bans.first.user.username
      result = subject.where_username(username).all

      expect(result).to eq(expected_bans)
    end
  end
end