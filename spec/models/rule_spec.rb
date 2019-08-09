require "rails_helper"

RSpec.describe Rule do
  subject { described_class }

  it_behaves_like "paginatable"
end