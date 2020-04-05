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

  describe ".stale" do
    it "returns stale mutes" do
      stale_mutes = create_pair(:mute, :stale)
      create_pair(:mute)

      result = subject.new.stale

      expect(result).to match_array(stale_mutes)
    end
  end
end
