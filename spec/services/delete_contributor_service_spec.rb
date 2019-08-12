require "rails_helper"

RSpec.describe DeleteContributorService do
  subject { described_class }

  describe ".call" do
    let!(:contributor) { create(:contributor) }

    before do
      @service = subject.new(contributor)
    end

    it "delete contributor" do
      expect { @service.call }.to change { Contributor.count }.by(-1)
    end
  end
end