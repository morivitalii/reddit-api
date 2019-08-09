require "rails_helper"

RSpec.describe Tag do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "strip attributes", :title, squish: true
end