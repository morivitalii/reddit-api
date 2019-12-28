require "rails_helper"

RSpec.describe Vote do
  it_behaves_like "paginatable"

  context "validations" do
    subject { create(:vote) }

    it { is_expected.to define_enum_for(:vote_type).with_values(up: 1, down: -1) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to([:votable_type, :votable_id]) }
    it { is_expected.to validate_presence_of(:vote_type) }
  end
end
