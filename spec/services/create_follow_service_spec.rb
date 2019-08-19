require "rails_helper"

RSpec.describe CreateFollowService do
  subject { described_class }

  describe ".call" do
    context "when follow exists" do
      it "does not create new one" do
        service = build_create_follow_service
        follow = instance_double(Follow)
        allow(service).to receive(:follow).and_return(follow)

        expect { service.call }.to_not change { Follow.count }
      end

      it "returns existent follow" do
        service = build_create_follow_service
        follow = instance_double(Follow)
        allow(service).to receive(:follow).and_return(follow)

        result = service.call

        expect(result).to eq(follow)
      end
    end

    context "when follow does not exist" do
      it "creates new one" do
        service = build_create_follow_service

        expect { service.call }.to change { Follow.count }.by(1)
      end

      it "returns created follow" do
        service = build_create_follow_service

        follow = service.call
        expect(follow).to be_persisted
        expect(follow.community).to eq(service.community)
        expect(follow.user).to eq(service.user)
      end
    end
  end

  def build_create_follow_service
    user = create(:user)
    community = create(:community)

    described_class.new(community, user)
  end
end