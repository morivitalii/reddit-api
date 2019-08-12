require "rails_helper"

RSpec.describe ApplicationFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }

  describe ".user_ban" do
    context "visitor" do
      let(:user) { nil }

      it "returns nil" do
        result = subject.new(context).user_ban

        expect(result).to be_nil
      end
    end

    context "user" do
      let!(:ban) { create(:ban, sub: sub, user: user) }

      it "returns user ban" do
        result = subject.new(context).user_ban

        expect(result).to eq(ban)
      end
    end
  end

  describe ".subs_moderated_by_user" do
    context "visitor" do
      let(:user) { nil }

      it "returns blank array" do
        result = subject.new(context).subs_moderated_by_user

        expect(result).to be_blank
      end
    end

    context "user" do
      let!(:expected) { create(:sub) }
      let!(:others) { create_pair(:sub) }
      let!(:moderator) { create(:moderator, sub: expected, user: user) }

      it "returns subs where user is moderator" do
        result = subject.new(context).subs_moderated_by_user

        expect(result).to contain_exactly(*expected)
      end
    end
  end

  describe ".subs_followed_by_user" do
    context "visitor" do
      let!(:user) { nil }

      it "returns blank array" do
        result = subject.new(context).subs_followed_by_user

        expect(result).to be_blank
      end
    end

    context "user" do
      let!(:expected) { create(:sub) }
      let!(:others) { create_pair(:sub) }
      let!(:follow) { create(:follow, sub: expected, user: user) }

      it "returns subs where user is follower" do
        result = subject.new(context).subs_followed_by_user

        expect(result).to contain_exactly(*expected)
      end
    end
  end

  describe ".rules" do
    let!(:expected) { create_pair(:rule, sub: sub) }
    let!(:others) { create_pair(:rule) }

    it "returns rules" do
      result = subject.new(context).rules

      expect(result).to contain_exactly(*expected)
    end
  end

  describe ".recent_moderators" do
    let!(:expected) { create_pair(:moderator, sub: sub) }
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