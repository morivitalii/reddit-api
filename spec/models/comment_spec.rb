require "rails_helper"

RSpec.describe Comment do
  it_behaves_like "paginatable"
  it_behaves_like "editable"
end