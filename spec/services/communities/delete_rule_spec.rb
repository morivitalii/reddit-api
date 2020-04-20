require "rails_helper"

RSpec.describe Communities::DeleteRule do
  describe ".call" do
    it "deletes rule" do
      rule = create(:rule)
      service = described_class.new(rule: rule)

      service.call

      expect(Rule.count).to eq(0)
    end
  end
end
