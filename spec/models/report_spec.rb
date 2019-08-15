require "rails_helper"

RSpec.describe Report, type: :model do
  subject { described_class }

  it_behaves_like "paginatable"
end