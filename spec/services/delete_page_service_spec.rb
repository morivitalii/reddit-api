require "rails_helper"

RSpec.describe DeletePageService do
  subject { described_class.new(page) }

  let!(:page) { create(:page) }

  describe ".call" do
    it "delete page" do
      expect { subject.call }.to change { Page.count }.by(-1)
    end
  end
end