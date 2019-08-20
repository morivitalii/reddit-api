require "rails_helper"

RSpec.shared_examples_for "removable" do
  it_behaves_like "strip attributes", :removed_reason, squish: true

  let(:removed_by) { build(:user) }
  let(:reason) { "Reason" }

  before do
    @model = create(subject.to_s.underscore.to_sym)
  end

  describe ".undo_approve" do
    it "calls .undo_approve on remove" do
      allow(@model).to receive(:removing?).and_return(true)
      expect(@model).to receive(:undo_approve)

      @model.save!
    end
  end

  describe ".remove!" do
    it "call .remove on self" do
      expect(@model).to receive(:remove).with(removed_by, reason).once

      @model.remove!(removed_by, reason)
    end

    it "call .save! on self" do
      expect(@model).to receive(:save!).once

      @model.remove!(removed_by, reason)
    end
  end

  describe ".remove" do
    it "sets remove attributes" do
      expect { @model.remove(removed_by, reason) }.to change { [@model.removed_by, @model.removed_at, @model.removed_reason] }
    end
  end

  describe ".undo_remove" do
    it "sets remove attributes values to nil" do
      @model.removed_by = removed_by
      @model.removed_at = Time.current
      @model.removed_reason = reason

      expect { @model.undo_remove }.to change { [@model.removed_by, @model.removed_at, @model.removed_reason] }
    end
  end

  describe ".removable?" do
    it { is_expected.to be_truthy }
  end

  describe ".removing?" do
    context "not removing" do
      it "returns false" do
        @model.removed_at = nil

        result = @model.removing?

        expect(result).to be_falsey
      end
    end

    context "removing" do
      it "returns true" do
        @model.removed_at = Time.current

        result = @model.removing?

        expect(result).to be_truthy
      end
    end
  end

  describe ".removed?" do
    context "not removed" do
      it "returns false" do
        @model.removed_at = nil

        result = @model.removed?

        expect(result).to be_falsey
      end
    end

    context "removed" do
      it "returns true" do
        @model.removed_at = Time.current

        result = @model.removed?

        expect(result).to be_truthy
      end
    end
  end
end