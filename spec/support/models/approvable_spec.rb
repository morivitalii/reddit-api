require "rails_helper"

RSpec.shared_examples_for "approvable" do
  let(:approved_by) { build(:user) }

  before do
    @model = create(subject.to_s.underscore.to_sym)
  end

  it "approves model on create if user have permissions for approving" do
    model = build(subject.to_s.underscore.to_sym)
    allow(model).to receive(:auto_approve?).and_return(true)

    expect(model).to receive(:approve).with(model.user).once

    model.save!
  end

  it "does not approve model on create if user have not permissions for approving" do
    model = build(subject.to_s.underscore.to_sym)
    allow(model).to receive(:auto_approve?).and_return(false)

    expect(model).to_not receive(:approve)

    model.save!
  end

  describe ".approvable?" do
    it { is_expected.to be_truthy }
  end

  describe ".undo_approve", if: @model.respond_to?(:removable?) do
    it "calls .undo_remove on approve" do
      allow(@model).to receive(:approving?).and_return(true)
      expect(@model).to receive(:undo_remove)

      @model.save!
    end
  end

  describe ".approve!" do
    it "call .approve on self" do
      expect(@model).to receive(:approve).with(approved_by).once

      @model.approve!(approved_by)
    end

    it "call .save! on self" do
      expect(@model).to receive(:save!).once

      @model.approve!(approved_by)
    end
  end

  describe ".approve" do
    it "sets approve attributes" do
      expect { @model.approve(approved_by) }.to change { [@model.approved_by, @model.approved_at] }
    end
  end

  describe ".undo_approve" do
    it "sets approve attributes values to nil" do
      @model.approved_by = approved_by
      @model.approved_at = Time.current

      expect { @model.undo_approve }.to change { [@model.approved_by, @model.approved_at] }
    end
  end

  describe ".approving?" do
    context "not approving" do
      it "returns false" do
        @model.approved_at = nil

        result = @model.approving?

        expect(result).to be_falsey
      end
    end

    context "approving" do
      it "returns true" do
        @model.approved_at = Time.current

        result = @model.approving?

        expect(result).to be_truthy
      end
    end
  end

  describe ".aproved?" do
    context "not approved" do
      it "returns false" do
        @model.approved_at = nil

        result = @model.approved?

        expect(result).to be_falsey
      end
    end

    context "approved" do
      it "returns true" do
        @model.approved_at = Time.current

        result = @model.approved?

        expect(result).to be_truthy
      end
    end
  end
end