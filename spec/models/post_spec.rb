require "rails_helper"

RSpec.describe Post do
  it_behaves_like "paginatable"
  it_behaves_like "editable"
end