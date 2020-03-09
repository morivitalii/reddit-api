require "rails_helper"

RSpec.describe MutesQuery do
  subject { described_class }

  describe ".with_username" do
    it "returns mutes with given user username" do
      user = create(:user)
      user_mutes = create_pair(:mute, user: user)
      create_pair(:mute)

      result = subject.new.with_username(user.username)

      expect(result).to match_array(user_mutes)
    end
  end

  describe ".search_by_username" do
    it "returns relation if user username is blank" do
      query = subject.new

      result = query.search_by_username("")

      expect(result).to eq(query.relation)
    end

    it "calls .with_username if user username is present" do
      username = "username"
      query = subject.new
      allow(query).to receive(:with_username)

      query.search_by_username(username)

      expect(query).to have_received(:with_username).with(username)
    end
  end

  describe ".stale" do
    it "returns stale mutes" do
      stale_mutes = create_pair(:mute, :stale)
      create_pair(:mute)

      result = subject.new.stale

      expect(result).to match_array(stale_mutes)
    end
  end
end
