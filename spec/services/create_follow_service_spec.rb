require "rails_helper"

RSpec.describe CreateFollowService do
  subject { described_class }

  describe ".call" do
    let(:sub) { create(:sub) }
    let(:user) { create(:user) }

    before do
      @service = subject.new(sub, user)
    end

    context "does not exist" do
      it "create new one" do
        expect { @service.call }.to change { Follow.count }.by(1)
      end

      it "return created" do
        result = @service.call

        expect(result).to be_instance_of(Follow)
        expect(result).to have_attributes(sub: sub, user: user)
      end
    end

    context "exists" do
      let!(:follow) { create(:follow, sub: sub, user: user) }

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