require "rails_helper"

RSpec.describe Page do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "editable"
  it_behaves_like "markdownable", :text
  it_behaves_like "strip attributes", :title, squish: true
  it_behaves_like "strip attributes", :text
end