require "rails_helper"

RSpec.describe BansQuery do
  subject { described_class }

  describe ".stale" do
    it "returns stale bans" do
      stale_bans = create_pair(:ban, :stale)
      create_pair(:ban)

      result = subject.new.stale

      expect(result).to match_array(stale_bans)
    end
  end
end
