require "rails_helper"

RSpec.describe Api::Users::Votes::Ups::PostsPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    let(:user) { create(:user) }

    permissions :index? do
      it { is_expected.to_not permit(context, user) }
    end
  end

  context "for user", context: :user do
    context "another user" do
      let(:user) { create(:user) }

      permissions :index? do
        it { is_expected.to_not permit(context, user) }
      end
    end

    context "account owner" do
      let(:user) { context.user }

      permissions :index? do
        it { is_expected.to permit(context, user) }
      end
    end
  end
end
