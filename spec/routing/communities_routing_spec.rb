require "rails_helper"

RSpec.describe "routes for CommunitiesController", type: :routing do
  it "routes GET /communities to page_not_found#show" do
    expect(get("/communities")).to route_to(controller: "page_not_found", action: "show", path: "communities")
  end

  it "routes GET /communities/all to communities#show" do
    expect(get("/communities/all")).to route_to(controller: "communities", action: "show", id: "all")
  end

  it "routes GET /communities/new to communities#show" do
    expect(get("/communities/new")).to route_to(controller: "communities", action: "show", id: "new")
  end

  it "routes POST /communities to page_not_found#show" do
    expect(post("/communities")).to route_to(controller: "page_not_found", action: "show", path: "communities")
  end

  it "routes GET /communities/all/edit to communities#edit" do
    expect(get("/communities/all/edit")).to route_to(controller: "communities", action: "edit", id: "all")
  end

  it "routes PUT /communities/all to communities#update" do
    expect(patch("/communities/all")).to route_to(controller: "communities", action: "update", id: "all")
  end

  it "routes PATCH /communities/all to communities#update" do
    expect(patch("/communities/all")).to route_to(controller: "communities", action: "update", id: "all")
  end

  it "routes DELETE /communities/all to page_not_found#show" do
    expect(delete("/communities/all")).to route_to(controller: "page_not_found", action: "show", path: "communities/all")
  end
end