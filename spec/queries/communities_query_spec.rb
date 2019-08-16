require "rails_helper"

RSpec.describe CommunitiesQuery do
  subject { described_class }

  describe ".with_url" do
    it "returns community with given url" do
      community = create(:community)
      create_pair(:community)

      result = subject.new.with_url(community.url).take

      expect(result).to eq(community)
    end
  end

  describe ".default" do
    it "returns default community" do
      default_community = create(:default_community)
      create_pair(:community)

      result = subject.new.default.take

      expect(result).to eq(default_community)
    end
  end

  describe ".with_user_moderator" do
    it "returns communities where user is moderator" do
      user = create(:user)
      communities_with_user_moderator = create_pair(:community_with_moderators, moderator_user: user, moderators_count: 1)
      create_pair(:community_with_moderators, moderators_count: 1)

      result = subject.new.with_user_moderator(user)

      expect(result).to contain_exactly(*communities_with_user_moderator)
    end
  end

  describe ".with_user_follower" do
    it "returns communities where user is follower" do
      user = create(:user)
      communities_with_user_follower = create_pair(:community_with_followers, follower_user: user, followers_count: 1)
      create_pair(:community_with_followers, followers_count: 1)

      result = subject.new.with_user_follower(user)

      expect(result).to contain_exactly(*communities_with_user_follower)
    end
  end
end