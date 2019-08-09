require "rails_helper"

RSpec.describe Vote do
  subject { described_class }

  it_behaves_like "paginatable"
end