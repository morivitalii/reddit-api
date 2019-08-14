require "rails_helper"

RSpec.describe CreateFollowService do
  subject { described_class }

  describe ".call" do
    let(:community) { create(:community) }
    let(:user) { create(:user) }

    before do
      @service = subject.new(community, user)
    end

    context "does not exist" do
      it "create new one" do
        expect { @service.call }.to change { Follow.count }.by(1)
      end

      it "return created" do
        result = @service.call

        expect(result).to be_instance_of(Follow)
        expect(result).to have_attributes(community: community, user: user)
      end
    end

    context "exists" do
      let!(:follow) { create(:follow, community: community, user: user) }

      it "does not create new one" do
        expect { @service.call }.to_not change { Follow.count }
      end

      it "returns existent" do
        result = @service.call

        expect(result).to eq(follow)
      end
    end
  end
end