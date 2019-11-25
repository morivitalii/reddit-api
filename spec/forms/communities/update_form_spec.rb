require "rails_helper"

RSpec.describe Communities::UpdateForm do
  describe ".save" do
    it "updates community" do
      form = build_update_community_form

      form.save

      community = form.community
      expect(community.title).to eq(form.title)
      expect(community.description).to eq(form.description)
    end
  end

  def build_update_community_form
    community = create(:community)

    described_class.new(
      community: community,
      title: "Title",
      description: "Description"
    )
  end
end
