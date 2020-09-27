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

  describe ".with_user_moderator" do
    it "returns communities where user is moderator" do
      user = create(:user)
      communities_where_user_moderator = create_pair(:community_with_moderators, moderator_user: user, moderators_count: 1)
      create_pair(:community_with_moderators, moderators_count: 1)

      result = subject.new.with_user_moderator(user)

      expect(result).to match_array(communities_where_user_moderator)
    end
  end

  describe ".with_user_follower" do
    it "returns communities where user is follower" do
      user = create(:user)
      communities_where_user_follower = create_pair(:community_with_followers, user: user, followers_count: 1)
      create_pair(:community_with_followers, followers_count: 1)

      result = subject.new.with_user_follower(user)

      expect(result).to match_array(communities_where_user_follower)
    end
  end

  describe ".with_user_banned" do
    it "returns communities where user is banned" do
      user = create(:user)
      communities_where_user_banned = create_pair(:community_with_users_bans, user: user, bans_count: 1)
      create_pair(:community_with_users_bans, bans_count: 1)

      result = subject.new.with_user_banned(user)

      expect(result).to match_array(communities_where_user_banned)
    end
  end
end
