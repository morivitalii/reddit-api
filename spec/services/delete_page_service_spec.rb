require "rails_helper"

RSpec.describe DeletePageService do
  subject { described_class }

  describe ".call" do
    let!(:page) { create(:page) }

    before do
      @service = subject.new(page)
    end

    it "delete page" do
      expect { @service.call }.to change { Page.count }.by(-1)
    end
  end
end