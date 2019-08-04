require "rails_helper"

RSpec.describe SubsQuery do
  subject { described_class.new }

  describe ".where_url" do
    let!(:subs) { create_pair(:sub) }

    it "returns sub with given url" do
      expected_result = [subs.first]
      url = expected_result.first.url
      result = subject.where_url(url).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".default" do
    let!(:subs) { [create(:sub)] }
    let!(:default_sub) { [create(:sub, url: "all")] }

    it "return default sub" do
      expected_result = default_sub
      result = subject.default.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_user_moderator" do
    let!(:user) { create(:user) }
    let!(:sub) { create(:sub) }
    let!(:user_sub_moderators) { [create(:sub_moderator, sub: sub, user: user)] }
    let!(:other_sub_moderators) { create(:sub_moderator, sub: sub) }

    it "returns subs where user is moderator" do
      expected_result = [sub]
      result = subject.where_user_moderator(user).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_user_follower" do
    let!(:user) { create(:user) }
    let!(:sub) { create(:sub) }
    let!(:user_sub_followers) { [create(:follow, sub: sub, user: user)] }
    let!(:other_sub_followers) { create(:follow, sub: sub) }

    it "returns subs where user is follower" do
      expected_result = [sub]
      result = subject.where_user_follower(user).all

      expect(result).to eq(expected_result)
    end
  end
end