require "rails_helper"

RSpec.describe Api::ForgotPasswordPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes_for_create).to contain_exactly(:email)
    end
  end
end
