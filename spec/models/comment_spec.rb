require "rails_helper"

RSpec.describe Comment do
  it_behaves_like "paginatable"
  it_behaves_like "editable"
  it_behaves_like "bookmarkable"
  it_behaves_like "votable"
  it_behaves_like "removable"
end