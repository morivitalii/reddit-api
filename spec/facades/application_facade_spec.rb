require "rails_helper"

RSpec.describe ApplicationFacade, type: :facade do
  subject { described_class }

  describe ".communities_moderated_by_user" do
    context "for visitor" do
      include_context "visitor context"

      it "returns blank array" do
        result = subject.new(context).communities_moderated_by_user

        expect(result).to be_blank
      end
    end

    context "for user" do
      include_context "user context"

      it "returns communities where user is moderator" do
        communities = create_pair(:community_with_user_moderator, user: context.user)
        create_pair(:community)

        result = subject.new(context).communities_moderated_by_user

        expect(result).to match_array(communities)
      end
    end
  end

  describe ".communities_followed_by_user" do
    context "for visitor" do
      include_context "visitor context"

      it "returns blank array" do
        result = subject.new(context).communities_followed_by_user

        expect(result).to be_blank
      end
    end

    context "for user" do
      include_context "user context"

      it "returns communities where user is follower" do
        communities = create_pair(:community_with_user_follower, user: context.user)
        create_pair(:community)

        result = subject.new(context).communities_followed_by_user

        expect(result).to match_array(communities)
      end
    end
  end

  describe ".rules" do
    include_context "default context"

    it "returns rules ordered by asc" do
      rules = create_pair(:rule, community: context.community)
      create_pair(:rule)

      result = subject.new(context).rules

      expect(result).to eq(rules)
    end
  end

  describe ".recent_moderators" do
    include_context "default context"

    it "returns limited moderators ordered by asc" do
      moderators = create_pair(:moderator, community: context.community)
      create_pair(:moderator)

      result = subject.new(context).recent_moderators

      expect(result).to eq(moderators)
    end
  end
end