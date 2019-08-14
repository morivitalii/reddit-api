require "rails_helper"

RSpec.describe CommunitiesQuery do
  subject { described_class }

  describe ".with_url" do
    let!(:expected) { create(:community) }
    let!(:others) { create_pair(:community) }

    it "returns results filtered by url" do
      result = subject.new.with_url(expected.url).take

      expect(result).to eq(expected)
    end
  end

  describe ".default" do
    it "calls .with_url with 'all'" do
      query = subject.new

      expect(query).to receive(:with_url).with("all")

      query.default
    end
  end

  describe ".with_user_moderator" do
    let!(:user) { create(:user) }
    let!(:expected) { create(:community) }
    let!(:moderator) { create(:moderator, community: expected, user: user) }
    let!(:others) { create(:community) }

    it "returns communities where user moderator" do
      result = subject.new.with_user_moderator(user)

      expect(result).to eq([expected])
    end
  end

  describe ".with_user_follower" do
    let!(:user) { create(:user) }
    let!(:expected) { create(:community) }
    let!(:moderator) { create(:follow, community: expected, user: user) }
    let!(:others) { create(:community) }

    it "returns communities where user follower" do
      result = subject.new.with_user_follower(user)

      expect(result).to eq([expected])
    end
  end
end