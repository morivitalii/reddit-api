require "rails_helper"

RSpec.describe DeleteBanService do
  subject { described_class }

  describe ".call" do
    it "deletes ban" do
      ban = create(:ban)
      service = subject.new(ban)

      service.call

      expect(ban).to be_destroyed
    end
  end
end