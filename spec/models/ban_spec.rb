require "rails_helper"

RSpec.describe Ban do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "validations" do
    subject { create(:ban) }

    it { is_expected.to validate_presence_of(:user).with_message(:invalid_username) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:community_id) }
    it { is_expected.to validate_length_of(:reason).is_at_most(500) }

    context "when ban is temporary" do
      before do
        allow(subject).to receive(:permanent).and_return(false)
      end

      it { is_expected.to validate_presence_of(:days) }
      it { is_expected.to validate_numericality_of(:days).only_integer.is_greater_than(0).is_less_than_or_equal_to(365) }
      it { is_expected.to validate_presence_of(:days) }
    end

    context "when ban is permanent" do
      before do
        allow(subject).to receive(:permanent).and_return(true)
      end

      it { is_expected.to validate_absence_of(:days) }
    end
  end

  context "when ban is permanent" do
    context "ending date" do
      it "is blank" do
        ban = create(:permanent_ban)

        expect(ban.end_at).to be_blank
      end
    end
  end

  context "when ban is temporary" do
    context "ending date" do
      it "is :days in the future" do
        created_at = Time.current
        days = 2
        ban_ending_date = created_at + days.days

        ban = create(:temporary_ban, created_at: created_at, days: days)

        expect(ban.end_at).to eq(ban_ending_date)
      end
    end
  end
end
