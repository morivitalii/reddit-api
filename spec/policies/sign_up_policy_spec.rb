require "rails_helper"

RSpec.describe SignUpPolicy do
  subject { described_class }

  let(:context) { Context.new(user) }

  context "for visitor" do
    let(:user) { nil }

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end
  end
end