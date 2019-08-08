require "rails_helper"

RSpec.shared_examples_for "removable" do
  let(:deleted_by) { build(:user) }
  let(:reason) { "Reason" }

  before do
    @model = create(described_class.to_s.underscore.to_sym)
  end

  describe ".undo_approve", if: @model.respond_to?(:approvable?) do
    it "calls .undo_approve on remove" do
      allow(@model).to receive(:removing?).and_return(true)
      expect(@model).to receive(:undo_approve)

      @model.save!
    end
  end

  describe ".remove!" do
    it "call .remove on self" do
      expect(@model).to receive(:remove).with(deleted_by, reason).once

      @model.remove!(deleted_by, reason)
    end

    it "call .save! on self" do
      expect(@model).to receive(:save!).once

      @model.remove!(deleted_by, reason)
    end
  end

  describe ".remove" do
    it "sets remove attributes" do
      expect { @model.remove(deleted_by, reason) }.to change { [@model.deleted_by, @model.deleted_at, @model.deletion_reason] }
    end
  end

  describe ".undo_remove" do
    it "sets remove attributes values to nil" do
      @model.deleted_by = deleted_by
      @model.deleted_at = Time.current
      @model.deletion_reason = reason

      expect { @model.undo_remove }.to change { [@model.deleted_by, @model.deleted_at, @model.deletion_reason] }
    end
  end

  describe ".removable?" do
    it { is_expected.to be_truthy }
  end

  describe ".removing?" do
    context "not removing" do
      it "returns false" do
        @model.deleted_at = nil

        result = @model.removing?

        expect(result).to be_falsey
      end
    end

    context "removing" do
      it "returns true" do
        @model.deleted_at = Time.current

        result = @model.removing?

        expect(result).to be_truthy
      end
    end
  end

  describe ".removed?" do
    context "not removed" do
      it "returns false" do
        @model.deleted_at = nil

        result = @model.removed?

        expect(result).to be_falsey
      end
    end

    context "removed" do
      it "returns true" do
        @model.deleted_at = Time.current

        result = @model.removed?

        expect(result).to be_truthy
      end
    end
  end
end