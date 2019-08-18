require "rails_helper"

RSpec.describe BansQuery do
  subject { described_class }

  describe ".with_username" do
    it "returns bans with given user username" do
      user = create(:user)
      user_bans = create_pair(:ban, user: user)
      create_pair(:ban)

      result = subject.new.with_username(user.username)

      expect(result).to match_array(user_bans)
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
    it "returns stale bans" do
      stale_bans = create_pair(:ban, :stale)
      create_pair(:ban)

      result = subject.new.stale

      expect(result).to match_array(stale_bans)
    end
  end
end