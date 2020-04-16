require "rails_helper"

RSpec.describe MutesQuery do
  subject { described_class }

  describe ".stale" do
    it "returns stale mutes" do
      stale_mutes = create_pair(:mute, :stale)
      create_pair(:mute)

      result = subject.new.stale

      expect(result).to match_array(stale_mutes)
    end
  end
end
