require "rails_helper"

RSpec.describe ApplicationFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:global_context) { Context.new(user) }
  let(:sub_context) { Context.new(user, sub) }

  describe ".user_ban" do
    context "global" do
      context "visitor" do
        let(:user) { nil }

        it "returns nil" do
          expected_result = nil
          result = subject.new(global_context).user_ban

          expect(result).to eq(expected_result)
        end
      end

      context "user" do
        let!(:ban) { create(:global_ban, user: user) }

        it "returns ban" do
          expected_result = ban
          result = subject.new(global_context).user_ban

          expect(result).to eq(expected_result)
        end
      end
    end

    context "sub" do
      context "visitor" do
        let(:user) { nil }

        it "returns nil" do
          expected_result = nil
          result = subject.new(sub_context).user_ban

          expect(result).to eq(expected_result)
        end
      end

      context "user" do
        let!(:ban) { create(:sub_ban, sub: sub, user: user) }

        it "returns ban" do
          expected_result = ban
          result = subject.new(sub_context).user_ban

          expect(result).to eq(expected_result)
        end
      end
    end
  end

  describe ".subs_where_user_moderator" do
    context "visitor" do
      let!(:user) { nil }

      it "returns blank array" do
        expected_result = []
        result = subject.new(global_context).subs_where_user_moderator

        expect(result).to eq(expected_result)
      end
    end

    context "user" do
      let!(:sub_moderator) { create(:sub_moderator, sub: sub, user: user) }

      it "returns subs where user is moderator" do
        expected_result = [sub]
        result = subject.new(global_context).subs_where_user_moderator

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".subs_where_user_follower" do
    context "visitor" do
      let!(:user) { nil }

      it "returns blank array" do
        expected_result = []
        result = subject.new(global_context).subs_where_user_follower

        expect(result).to eq(expected_result)
      end
    end

    context "user" do
      let!(:sub_follow) { create(:follow, sub: sub, user: user) }

      it "returns subs where user is follower" do
        expected_result = [sub]
        result = subject.new(global_context).subs_where_user_follower

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".rules" do
    let!(:global_rules) { create_pair(:global_rule) }
    let!(:sub_rules) { create_pair(:sub_rule, sub: sub) }

    context "global" do
      it "returns global rules" do
        expected_result = global_rules
        result = subject.new(global_context).rules

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns sub rules" do
        expected_result = sub_rules
        result = subject.new(sub_context).rules

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".recent_moderators" do
    let!(:global_moderators) { create_pair(:global_moderator) }
    let!(:sub_moderators) { create_pair(:sub_moderator, sub: sub) }

    context "global" do
      it "returns global moderators" do
        expected_result = global_moderators
        result = subject.new(global_context).recent_moderators

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns sub moderators" do
        expected_result = sub_moderators
        result = subject.new(sub_context).recent_moderators

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".recent_pages" do
    let!(:global_pages) { create_pair(:global_page) }
    let!(:sub_pages) { create_pair(:sub_page, sub: sub) }

    context "global" do
      it "returns global pages" do
        expected_result = global_pages
        result = subject.new(global_context).recent_pages

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns sub pages" do
        expected_result = sub_pages
        result = subject.new(sub_context).recent_pages

        expect(result).to eq(expected_result)
      end
    end
  end
end