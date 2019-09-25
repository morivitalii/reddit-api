require "rails_helper"

RSpec.describe ApplicationController do
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

    before { stub_pundit_user }
    before { stub_current_user }

    context "for visitor", context: :visitor do
      context "when request is xhr" do
        before { get :index, xhr: true }

        it { is_expected.to render_template("/sign_in/_new") }
        it { is_expected.to respond_with(:unauthorized) }
      end

      context "when request is not xhr" do
        before { get :index }

        it { is_expected.to render_template("/authorization_error") }
        it { is_expected.to respond_with(:forbidden) }
      end
    end

    context "for user", context: :user do
      context "when request is xhr" do
        before { get :index, xhr: true }

        it { expect(response.body).to be_blank }
        it { is_expected.to respond_with(:forbidden) }
      end

      context "when request is not xhr" do
        before { get :index }

        it { is_expected.to render_template("/authorization_error") }
        it { is_expected.to respond_with(:forbidden) }
      end
    end
  end

  describe ".pundit_user", context: :user do
    it "returns context class instance" do
      stub_pundit_user

      expect(controller.view_context.pundit_user).to be_a(Context)
    end
  end

  describe ".user_signed_in?" do
    context "for visitor", context: :visitor do
      it "returns false" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_in?).to be_falsey
      end
    end

    context "for user", context: :user do
      it "returns true" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_in?).to be_truthy
      end
    end
  end

  describe ".user_signed_out?" do
    context "for visitor", context: :visitor do
      it "returns true" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_out?).to be_truthy
      end
    end

    context "for user", context: :user do
      it "returns false" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.user_signed_out?).to be_falsey
      end
    end
  end

  describe ".communities_moderated_by_user" do
    context "for visitor", context: :visitor do
      it "returns blank array" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.communities_moderated_by_user).to be_blank
      end
    end

    context "for user", context: :user do
      it "returns communities where user is moderator" do
        stub_pundit_user
        stub_current_user
        current_user = controller.view_context.current_user

        communities = create_pair(:community_with_user_moderator, user: current_user)
        create_pair(:community)

        expect(controller.view_context.communities_moderated_by_user).to match_array(communities)
      end
    end
  end

  describe ".communities_followed_by_user" do
    context "for visitor", context: :visitor do
      it "returns blank array" do
        stub_pundit_user
        stub_current_user

        expect(controller.view_context.communities_followed_by_user).to be_blank
      end
    end

    context "for user", context: :user do
      it "returns communities where user is follower except those where user is moderator" do
        stub_pundit_user
        stub_current_user
        current_user = controller.view_context.current_user

        communities_with_user_follower = create_pair(:community_with_user_follower, user: current_user)
        community_with_user_moderator_and_follower = create(:community_with_user_follower, user: current_user)
        create(:moderator, community: community_with_user_moderator_and_follower, user: current_user)

        expect(controller.view_context.communities_followed_by_user).to match_array(communities_with_user_follower)
      end
    end
  end

  describe ".sidebar_rules", context: :user do
    it "returns rules" do
      stub_pundit_user
      community = controller.view_context.pundit_user.community

      rules = create_pair(:rule, community: community)
      create_pair(:rule)

      expect(controller.view_context.sidebar_rules).to eq(rules)
    end
  end

  describe ".sidebar_moderators", context: :user do
    it "returns moderators" do
      stub_pundit_user
      community = controller.view_context.pundit_user.community

      moderators = create_pair(:moderator, community: community)
      create_pair(:moderator)

      expect(controller.view_context.sidebar_moderators).to eq(moderators)
    end
  end

  describe ".validate_rate_limit" do
    context "when rate limiting is skipped" do
      it "returns true" do
        allow(controller).to receive(:skip_rate_limiting?).and_return(true)

        result = controller.send(:validate_rate_limit, double, double)

        expect(result).to be_truthy
      end
    end

    context "when user above action limits" do
      it "returns false and set error to provided model attribute" do
        model = build(:rate_limit)
        rate_limit = instance_double(RateLimit)
        allow(rate_limit).to receive(:hits).and_return(1)
        allow(controller).to receive(:get_rate_limit).with(:action).and_return(rate_limit)
        allow(controller).to receive(:skip_rate_limiting?).and_return(false)

        result = controller.send(:validate_rate_limit, model, { attribute: :action, action: :action, limit: 1 })

        expect(result).to be_falsey
        expect(model).to have_error(:rate_limit).on(:action)
      end
    end

    context "when user under action limits" do
      it "returns true" do
        model = build(:rate_limit)
        rate_limit = instance_double(RateLimit)
        allow(rate_limit).to receive(:hits).and_return(1)
        allow(controller).to receive(:get_rate_limit).with(:action).and_return(rate_limit)
        allow(controller).to receive(:skip_rate_limiting?).and_return(false)

        result = controller.send(:validate_rate_limit, model, { attribute: :action, action: :action, limit: 2 })

        expect(result).to be_truthy
      end
    end
  end

  describe ".hit_rate_limit" do
    it "increment user rate limit hits" do
      rate_limit = create(:rate_limit)
      allow(controller).to receive(:get_rate_limit).and_return(rate_limit)

      expect { controller.send(:hit_rate_limit, :action) }.to change { rate_limit.hits }.by(1)
    end
  end

  def stub_pundit_user
    allow(controller).to receive(:pundit_user).and_return(context)
  end

  def stub_current_user
    allow(controller).to receive(:current_user).and_return(context.user)
  end
end