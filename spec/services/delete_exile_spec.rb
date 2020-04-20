require "rails_helper"

RSpec.describe DeleteExile do
  describe ".call" do
    it "deletes exile" do
      exile = create(:exile)

      service = described_class.new(exile)

      service.call

      expect(Exile.count).to eq(0)
    end
  end
end
