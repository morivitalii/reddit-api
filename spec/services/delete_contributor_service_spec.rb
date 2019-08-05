require "rails_helper"

RSpec.describe DeleteContributorService do
  subject { described_class.new(contributor) }

  let!(:contributor) { create(:contributor) }

  describe ".call" do
    it "delete contributor" do
      expect { subject.call }.to change { Contributor.count }.by(-1)
    end
  end
end