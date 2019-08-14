require "rails_helper"

RSpec.describe UpdateCommunityForm do
  subject { described_class }

  describe ".save" do
    let(:community) { instance_double(Community, update!: "") }

    before do
      @form = subject.new(community: community)
    end

    it "calls .update! on community" do
      @form.save

      expect(community).to have_received(:update!).with(any_args).once
    end
  end
end