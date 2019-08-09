require "rails_helper"

RSpec.describe Comment do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "editable"
  it_behaves_like "bookmarkable"
  it_behaves_like "votable"
  it_behaves_like "approvable"
  it_behaves_like "removable"
  it_behaves_like "reportable"
  it_behaves_like "markdownable", :text
end