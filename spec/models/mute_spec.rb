require "rails_helper"

RSpec.describe Mute, type: :model do
  subject { described_class }

  describe "validations" do
    subject { create(:ban) }

    it { is_expected.to validate_presence_of(:source) }
    it { is_expected.to validate_uniqueness_of(:source_id).scoped_to(:source_type, :target_type, :target_id) }
    it { is_expected.to validate_presence_of(:target) }
    it { is_expected.to validate_presence_of(:created_by) }
    it { is_expected.to validate_presence_of(:updated_by) }
    it { is_expected.to validate_presence_of(:end_at) }
  end
end
