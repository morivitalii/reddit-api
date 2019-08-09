require "rails_helper"

RSpec.describe Ban do
  subject { build(described_class.to_s.underscore.to_sym) }

  it_behaves_like "paginatable"
  it_behaves_like "squished attribute", :reason

  it "set end_at attribute before save to nil if permanent" do
    subject.permanent = true
    subject.days = nil
    subject.save!

    expect(subject.end_at).to be_nil
  end

  it "set end_at attribute before save to calculated datetime if temporary" do
    subject.permanent = false
    subject.days = 1
    subject.save!

    result = subject.end_at
    expected_result = subject.created_at + 1.day

    expect(result).to eq(expected_result)
  end

  describe ".stale?" do
    context "permanent" do
      before do
        subject.permanent = true
      end

      it "returns false" do
        result = subject.stale?

        expect(result).to be_falsey
      end
    end

    context "temporary" do
      before do
        subject.permanent = false
      end

      it "returns true if end_at before current datetime" do
        subject.end_at = Time.current - 1.day
        result = subject.stale?

        expect(result).to be_truthy
      end

      it "returns false if end_at after current datetime" do
        subject.end_at = Time.current + 1.day
        result = subject.stale?

        expect(result).to be_falsey
      end
    end
  end
end