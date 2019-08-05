require "rails_helper"

RSpec.describe DeleteTagService do
  subject { described_class.new(tag) }

  let!(:tag) { create(:tag) }

  describe ".call" do
    it "delete blacklisted domain" do
      expect { subject.call }.to change { Tag.count }.by(-1)
    end
  end
end