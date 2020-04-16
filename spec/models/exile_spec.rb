require 'rails_helper'

RSpec.describe Exile, type: :model do
  subject { described_class }

  describe "validations" do
    subject { create(:exile) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:user) }
  end
end
