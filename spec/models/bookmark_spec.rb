require "rails_helper"

RSpec.describe Bookmark do
  subject { described_class }

  it_behaves_like "paginatable"
end
