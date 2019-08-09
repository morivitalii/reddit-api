require "rails_helper"

RSpec.describe Ban do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "squished attribute", :reason

  it "set end_at attribute before save to nil if permanent" do
    model = build(:ban, permanent: true, days: nil)
    model.save!

    expect(model.end_at).to be_nil
  end

  it "set end_at attribute before save to calculated datetime if temporary" do
    model = build(:ban, permanent: false, days: 1)
    model.save!

    result = model.end_at
    expected_result = model.created_at + 1.day

    expect(result).to eq(expected_result)
  end

  describe ".stale?" do
    context "permanent" do
      it "returns false" do
        model = build(:ban, permanent: true, days: nil)
        model.save!
        result = model.stale?

        expect(result).to be_falsey
      end
    end

    context "temporary" do
      it "returns true if end_at before current datetime" do
        model = build(:ban, created_at: 2.days.ago, permanent: false, days: 1)
        model.save!
        result = model.stale?

        expect(result).to be_truthy
      end

      it "returns false if end_at after current datetime" do
        model = build(:ban, created_at: Time.current, permanent: false, days: 1)
        model.save!
        result = model.stale?

        expect(result).to be_falsey
      end
    end
  end
end