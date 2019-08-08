require "rails_helper"

RSpec.shared_examples_for "bookmarkable" do
  describe ".bookmarkable?" do
    it { is_expected.to be_truthy }
  end
end