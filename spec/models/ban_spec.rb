require "rails_helper"

RSpec.describe Ban, type: :model do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "strip attributes", :reason, squish: true

  describe "validations" do
    subject { create(:ban) }

    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:community_id) }
    it { is_expected.to validate_length_of(:reason).is_at_most(500) }

    context "temporary" do
      before do
        allow(subject).to receive(:permanent).and_return(false)
      end

      it { is_expected.to validate_presence_of(:days) }
      it { is_expected.to validate_numericality_of(:days).only_integer.is_greater_than(0).is_less_than_or_equal_to(365) }
      it { is_expected.to validate_presence_of(:days) }
    end

    context "permanent" do
      before do
        allow(subject).to receive(:permanent).and_return(true)
      end

      it { is_expected.to validate_absence_of(:days) }
    end
  end

  it "sets end_at attribute to nil if permanent" do
    ban = build(:permanent_ban)
    ban.save

    expect(ban.end_at).to be_nil
  end

  it "sets end_at attribute if temporary" do
    ban = build(:temporary_ban)
    ban.save

    expected_result = ban.created_at + ban.days.days

    expect(ban.end_at).to eq(expected_result)
  end

  describe ".stale?" do
    context "permanent" do
      it "returns false" do
        ban = build(:permanent_ban)

        expect(ban).to_not be_stale
      end
    end

    context "temporary" do
      it "returns true if end_at before current datetime" do
        ban = build(:temporary_ban, created_at: 2.days.ago, days: 1)
        ban.save

        expect(ban).to be_stale
      end

      it "returns false if end_at after current datetime" do
        ban = build(:temporary_ban, created_at: Time.current, days: 1)
        ban.save

        expect(ban).to_not be_stale
      end
    end
  end
end