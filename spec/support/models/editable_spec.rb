require "rails_helper"

RSpec.shared_examples_for "editable" do
  let(:edited_by) { build(:user) }

  before do
    @model = create(subject.to_s.underscore.to_sym)
  end

  describe ".undo_approve" do
    it "calls .undo_approve on edit" do
      allow(@model).to receive(:editing?).and_return(true)
      expect(@model).to receive(:undo_approve)

      @model.save!
    end
  end

  describe ".edit!" do
    it "call .edit on self" do
      expect(@model).to receive(:edit).with(edited_by).once

      @model.edit!(edited_by)
    end

    it "call .save! on self" do
      expect(@model).to receive(:save!).once

      @model.edit!(edited_by)
    end
  end

  describe ".edit" do
    it "sets edit attributes" do
      expect { @model.edit(edited_by) }.to change { [@model.edited_by, @model.edited_at] }
    end
  end

  describe ".editable?" do
    it { is_expected.to be_truthy }
  end

  describe ".editing?" do
    context "not editing" do
      it "returns false" do
        @model.edited_at = nil

        result = @model.editing?

        expect(result).to be_falsey
      end
    end

    context "editing" do
      it "returns true" do
        @model.edited_at = Time.current

        result = @model.editing?

        expect(result).to be_truthy
      end
    end
  end

  describe ".edited?" do
    context "not edited" do
      it "returns false" do
        @model.edited_at = nil

        result = @model.edited?

        expect(result).to be_falsey
      end
    end

    context "edited" do
      it "returns true" do
        @model.edited_at = Time.current

        result = @model.edited?

        expect(result).to be_truthy
      end
    end
  end
end