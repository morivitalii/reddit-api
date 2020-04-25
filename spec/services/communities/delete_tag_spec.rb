require "rails_helper"

RSpec.describe Communities::DeleteTag do
  describe ".call" do
    it "deletes tag" do
      tag = create(:tag)
      service = described_class.new(tag: tag)

      service.call

      expect(Tag.count).to eq(0)
    end
  end
end
