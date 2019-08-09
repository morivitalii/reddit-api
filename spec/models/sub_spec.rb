require "rails_helper"

RSpec.describe Sub do
  subject { described_class }

  it_behaves_like "strip attributes", :title, :description, squish: true
end