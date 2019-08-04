require "rails_helper"

RSpec.describe BansQuery do
  subject { described_class.new }

  describe ".sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_bans) { [create(:sub_ban, sub: sub)] }
    let!(:global_bans) { [create(:global_ban)] }

    it "returns sub bans" do
      expected_result = sub_bans
      result = subject.sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".global" do
    let!(:sub_bans) { [create(:sub_ban)] }
    let!(:global_bans) { [create(:global_ban)] }

    it "returns global bans" do
      expected_result = global_bans
      result = subject.global.all

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

    it "returns ban where user has a given username" do
      expected_result = [bans.first]
      username = expected_result.first.user.username
      result = subject.filter_by_username(username).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".user_global_ban" do
    let!(:user) { create(:user) }
    let!(:global_ban) { create(:global_ban, user: user) }
    let!(:sub_ban) { create(:sub_ban, user: user) }

    it "returns user global ban" do
      expected_result = global_ban
      result = subject.user_global_ban(user).take

      expect(result).to eq(expected_result)
    end
  end

  describe ".user_sub_ban" do
    let!(:user) { create(:user) }
    let!(:sub) { create(:sub) }
    let!(:global_ban) { create(:global_ban, user: user) }
    let!(:sub_ban) { create(:sub_ban, user: user, sub: sub) }

    it "returns user sub ban" do
      expected_result = sub_ban
      result = subject.user_sub_ban(user, sub).take

      expect(result).to eq(expected_result)
    end
  end
end