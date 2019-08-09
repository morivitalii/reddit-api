require "rails_helper"

RSpec.describe Tag do
  subject { described_class }

  it_behaves_like "paginatable"
end