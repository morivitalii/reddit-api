require "rails_helper"

RSpec.describe ModeratorsQuery do
  subject { described_class.new }

  describe ".global" do
    let!(:sub_moderators) { [create(:sub_moderator)] }
    let!(:global_moderators) { [create(:global_moderator)] }

    it "returns global moderators" do
      expected_result = global_moderators
      result = subject.global.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_moderators) { [create(:sub_moderator, sub: sub)] }
    let!(:global_moderators) { [create(:global_moderator)] }

    it "returns sub moderators" do
      expected_result = sub_moderators
      result = subject.sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".global_or_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_moderators) { [create(:sub_moderator, sub: sub)] }
    let!(:global_moderators) { [create(:global_moderator)] }

    it "returns global and sub moderators" do
      expected_result = sub_moderators + global_moderators
      result = subject.global_or_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_username" do
    let!(:moderators) { create_pair(:moderator) }

    it "returns moderators if given user username is blank" do
      expected_result = moderators
      result = subject.filter_by_username(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns moderator where user has a given username" do
      expected_result = [moderators.first]
      username = expected_result.first.user.username
      result = subject.filter_by_username(username).all

      expect(result).to eq(expected_result)
    end
  end
end