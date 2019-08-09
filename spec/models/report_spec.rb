require "rails_helper"

RSpec.describe Report do
  subject { described_class }

  it_behaves_like "paginatable"
end