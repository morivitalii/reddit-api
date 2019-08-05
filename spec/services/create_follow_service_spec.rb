require "rails_helper"

RSpec.describe CreateFollowService do
  subject { described_class.new(sub, user) }

  let(:sub) { create(:sub) }
  let(:user) { create(:user) }

  describe ".call" do
    context "does not exist" do
      it "create new one" do
        expect { subject.call }.to change { Follow.count }.by(1)
      end

      it "return created" do
        result = subject.call

        expect(result).to be_instance_of(Follow)
        expect(result).to have_attributes(sub: sub, user: user)
      end
    end

    context "exists" do
      let!(:follow) { create(:follow, sub: sub, user: user) }

      it "does not create new one" do
        expect { subject.call }.to_not change { Follow.count }
      end

      it "returns existent" do
        expected_result = follow
        result = subject.call

        expect(result).to eq(expected_result)
      end
    end
  end
end