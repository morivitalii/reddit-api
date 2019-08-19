require "rails_helper"

RSpec.describe "routing for PageNotFoundController", type: :routing do
  it "routes GET /404 to page_not_found#show" do
    expect(get("/404")).to route_to(controller: "page_not_found", action: "show", path: "404")
  end
end
