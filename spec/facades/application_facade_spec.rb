require "rails_helper"

RSpec.describe ApplicationFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  describe ".user_ban" do
    context "visitor" do
      let(:user) { nil }

      it "returns nil" do
        result = subject.new(context).user_ban

        expect(result).to be_nil
      end
    end

    context "user" do
      let!(:ban) { create(:ban, community: community, user: user) }

      it "returns user ban" do
        result = subject.new(context).user_ban

        expect(result).to eq(ban)
      end
    end
  end

  describe ".communities_moderated_by_user" do
    context "visitor" do
      let(:user) { nil }

      it "returns blank array" do
        result = subject.new(context).communities_moderated_by_user

        expect(result).to be_blank
      end
    end

    context "user" do
      let!(:expected) { create(:community) }
      let!(:others) { create_pair(:community) }
      let!(:moderator) { create(:moderator, community: expected, user: user) }

      it "returns communities where user is moderator" do
        result = subject.new(context).communities_moderated_by_user

        expect(result).to contain_exactly(*expected)
      end
    end
  end

  describe ".communities_followed_by_user" do
    context "visitor" do
      let!(:user) { nil }

      it "returns blank array" do
        result = subject.new(context).communities_followed_by_user

        expect(result).to be_blank
      end
    end

    context "user" do
      let!(:expected) { create(:community) }
      let!(:others) { create_pair(:community) }
      let!(:follow) { create(:follow, community: expected, user: user) }

      it "returns communities where user is follower" do
        result = subject.new(context).communities_followed_by_user

        expect(result).to contain_exactly(*expected)
      end
    end
  end

  describe ".rules" do
    let!(:expected) { create_pair(:rule, community: community) }
    let!(:others) { create_pair(:rule) }

    it "returns rules" do
      result = subject.new(context).rules

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".recent_moderators" do
    let!(:expected) { create_pair(:moderator, community: community) }
    let!(:others) { create_pair(:moderator) }

    it "returns moderators" do
      result = subject.new(context).recent_moderators

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".pagination_params" do
    it "is empty by default" do
      result = subject.new(context).pagination_params

      expect(result).to be_blank
    end
  end
end