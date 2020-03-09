require 'rails_helper'

RSpec.describe Mute, type: :model do
  subject { described_class }

  describe "validations" do
    subject { create(:mute) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:community_id) }
    it { is_expected.to validate_length_of(:reason).is_at_most(500) }

    context "when mute is temporary" do
      before do
        allow(subject).to receive(:permanent).and_return(false)
      end

      it { is_expected.to validate_presence_of(:days) }
      it { is_expected.to validate_numericality_of(:days).only_integer.is_greater_than(0).is_less_than_or_equal_to(365) }
      it { is_expected.to validate_presence_of(:days) }
    end

    context "when mute is permanent" do
      before do
        allow(subject).to receive(:permanent).and_return(true)
      end

      it { is_expected.to validate_absence_of(:days) }
    end
  end

  context "when mute is permanent" do
    context "ending date" do
      it "is blank" do
        mute = create(:permanent_mute)

        expect(mute.end_at).to be_blank
      end
    end
  end

  context "when mute is temporary" do
    context "ending date" do
      it "is :days in the future" do
        created_at = Time.current
        days = 2
        mute_ending_date = created_at + days.days

        mute = create(:temporary_mute, created_at: created_at, days: days)

        expect(mute.end_at).to eq(mute_ending_date)
      end
    end
  end
end
