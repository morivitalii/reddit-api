require "rails_helper"

RSpec.describe DeleteTagService do
  subject { described_class }

  describe ".call" do
    let!(:tag) { create(:tag) }

    before do
      @service = subject.new(tag)
    end

    it "delete tag" do
      expect { @service.call }.to change { Tag.count }.by(-1)
    end
  end
end