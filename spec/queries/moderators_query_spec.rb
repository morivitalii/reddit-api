require "rails_helper"

RSpec.describe ModeratorsQuery do
  subject { described_class }

  describe ".with_username" do
    let!(:user) { create(:user) }
    let!(:expected) { create_pair(:moderator, user: user) }
    let!(:others) { create_pair(:moderator) }

    it "returns moderators where user has given username" do
      user = create(:user)
      moderators = create_pair(:moderator, user: user)
      create_pair(:moderator)

      result = subject.new.with_username(user.username)

      expect(result).to contain_exactly(*moderators)
    end
  end

  describe ".search_by_username" do
    it "returns relation if username is blank" do
      query = subject.new

      result = query.search_by_username("")

      expect(result).to eq(query.relation)
    end

    it "calls .with_username if username is present" do
      username = "username"
      query = subject.new
      allow(query).to receive(:with_username)

      query.search_by_username(username)

      expect(query).to have_received(:with_username).with(username)
    end
  end

  describe ".recent" do
    it "returns limited recent moderators" do
      moderators = create_list(:moderator, 3)
      recent_moderators = moderators[0..1]

      result = subject.new.recent(2)

      expect(result).to eq(recent_moderators)
    end
  end
end