require "rails_helper"

RSpec.describe Rule do
  subject { described_class }

  it_behaves_like "paginatable"

  it { expect(described_class::LIMIT).to eq(15) }

  describe "validations" do
    subject { build(:rule) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }

    context "on create" do
      context "limit per community" do
        context "above" do
          it "is invalid" do
            stub_const("#{described_class}::LIMIT", 0)
            rule = build(:rule)
            rule.validate

            expect(rule).to have_error(:limit).on(:title)
          end
        end

        context "under" do
          it "is valid" do
            stub_const("#{described_class}::LIMIT", 1)
            rule = build(:rule)

            expect(rule).to be_valid
          end
        end
      end
    end
  end
end
