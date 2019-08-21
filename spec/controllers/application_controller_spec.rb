require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  it { is_expected.to rescue_from(ActiveRecord::RecordNotFound).with(:page_not_found) }

  describe ".page_not_found" do
    controller do
      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    context "when request is xhr" do
      before { get :index, xhr: true }

      it { is_expected.to_not render_template("page_not_found/show") }
      it { is_expected.to respond_with(404) }
    end

    context "when request is not xhr" do
      before { get :index }

      it { is_expected.to render_template("page_not_found/show") }
      it { is_expected.to respond_with(404) }
    end
  end

  it { is_expected.to rescue_from(Pundit::NotAuthorizedError).with(:authorization_error) }

  describe ".authorization_error" do
    controller do
      def index
        raise Pundit::NotAuthorizedError
      end
    end

    context "when request is xhr" do
      before { get :index, xhr: true }

      it { is_expected.to_not render_template("/authorization_error") }
      it { is_expected.to respond_with(403) }
    end

    context "when request is not xhr" do
      before { get :index }

      it { is_expected.to_not render_template("/authorization_error") }
      it { is_expected.to respond_with(403) }
    end
  end

  describe ".pundit_user" do
    include_context "default context"

    it "returns context class instance" do
      stub_pundit_user

      expect(controller.view_context.pundit_user).to be_a(Context)
    end
  end

  describe ".user_signed_in?" do
    context "for visitor" do
      include_context "visitor context"

      it "returns false" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_in?).to be_falsey
      end
    end

    context "for user" do
      include_context "user context"

      it "returns true" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_in?).to be_truthy
      end
    end
  end

  describe ".user_signed_out?" do
    context "for visitor" do
      include_context "visitor context"

      it "returns true" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_out?).to be_truthy
      end
    end

    context "for user" do
      include_context "user context"

      it "returns false" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_out?).to be_falsey
      end
    end
  end

  describe ".communities_moderated_by_user" do
    context "for visitor" do
      include_context "visitor context"

      it "returns blank array" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.communities_moderated_by_user).to be_blank
      end
    end

    context "for user" do
      include_context "user context"

      it "returns communities where user is moderator" do
        stub_pundit_user
        stub_current_user

        communities = create_pair(:community_with_user_moderator, user: controller.view_context.current_user)
        create_pair(:community)

        expect(controller.view_context.communities_moderated_by_user).to match_array(communities)
      end
    end
  end

  describe ".communities_followed_by_user" do
    context "for visitor" do
      include_context "visitor context"

      it "returns blank array" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.communities_followed_by_user).to be_blank
      end
    end

    context "for user" do
      include_context "user context"

      it "returns communities where user is follower" do
        stub_pundit_user
        stub_current_user

        communities = create_pair(:community_with_user_follower, user: controller.view_context.current_user)
        create_pair(:community)

        expect(controller.view_context.communities_followed_by_user).to match_array(communities)
      end
    end
  end

  describe ".sidebar_rules" do
    include_context "default context"

    it "returns rules" do
      stub_pundit_user

      rules = create_pair(:rule, community: controller.view_context.pundit_user.community)
      create_pair(:rule)

      expect(controller.view_context.sidebar_rules).to eq(rules)
    end
  end

  describe ".sidebar_moderators" do
    include_context "default context"

    it "returns moderators" do
      stub_pundit_user

      moderators = create_pair(:moderator, community: controller.view_context.pundit_user.community)
      create_pair(:moderator)

      expect(controller.view_context.sidebar_moderators).to eq(moderators)
    end
  end

  describe "rate limiting" do
    describe ".check_rate_limits" do

    end

    describe ".hit_rate_limits" do

    end
  end

  def stub_pundit_user
    allow(controller).to receive(:pundit_user).and_return(context)
  end

  def stub_current_user
    allow(controller).to receive(:current_user).and_return(context.user)
  end
end