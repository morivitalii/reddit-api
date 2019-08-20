require "rails_helper"

RSpec.describe Post, type: :model do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "editable"
  it_behaves_like "votable"
  it_behaves_like "removable"
  it_behaves_like "reportable"
  it_behaves_like "markdownable", :text
  it_behaves_like "strip attributes", :title, squish: true
  it_behaves_like "strip attributes", :text

  context "when author have permissions for approving" do
    it "approves post on create" do
      model = build(:post)
      allow(model).to receive(:auto_approve?).and_return(true)

      model.save!

      expect(model.approved_by).to eq(model.user)
      expect(model.approved_at).to be_present
    end
  end

  context "when author have not permissions for approving" do
    it "does not approve post on create" do
      model = build(:post)
      allow(model).to receive(:auto_approve?).and_return(false)

      model.save!

      expect(model.approved_by).to be_blank
      expect(model.approved_at).to be_blank
    end
  end

  describe ".approve!" do
    it "approves post" do
      model = create(:post)
      approved_by = create(:user)

      model.approve!(approved_by)

      expect(model.approved_by).to eq(approved_by)
      expect(model.approved_at).to be_present
    end
  end

  describe ".approved?" do
    context "when post is approved" do
      it "returns true" do
        model = build(:approved_post)

        expect(model).to be_approved
      end
    end

    context "when post is not approved" do
      it "returns false" do
        model = build(:not_approved_post)

        expect(model).to_not be_approved
      end
    end
  end
end