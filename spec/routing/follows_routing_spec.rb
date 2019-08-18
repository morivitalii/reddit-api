require "rails_helper"

RSpec.describe "routes for FollowsController", type: :routing do
  it "routes GET /communities/all/follows to page_not_found#show" do
    expect(get("/communities/all/follows")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/follows")
  end

  it "routes GET /communities/all/follows/new to page_not_found#show" do
    expect(get("/communities/all/follows/new")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/follows/new")
  end

  it "routes POST /communities/all/follows to follows#create" do
    expect(post("/communities/all/follows")).to route_to(controller: "follows", action: "create", community_id: "all")
  end

  it "routes GET /communities/all/follows/edit to page_not_found#show" do
    expect(get("/communities/all/follows/edit")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/follows/edit")
  end

  it "routes PUT /communities/all/follows to page_not_found#show" do
    expect(put("/communities/all/follows")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/follows")
  end

  it "routes PATCH /communities/all/follows to page_not_found#show" do
    expect(patch("/communities/all/follows")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/follows")
  end

  it "routes DELETE /communities/all/follows to follows#destroy" do
    expect(delete("/communities/all/follows")).to route_to(controller: "follows", action: "destroy", community_id: "all")
  end
end