require "rails_helper"

RSpec.describe "routes for moderatorsController", type: :routing do
  it "routes GET /communities/all/moderators to moderators#index" do
    expect(get("/communities/all/moderators")).to route_to(controller: "moderators", action: "index", community_id: "all")
  end

  it "routes GET /communities/all/moderators/1 to page_not_found#show" do
    expect(get("/communities/all/moderators/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/moderators/1")
  end

  it "routes GET /communities/all/moderators/new to moderators#new" do
    expect(get("/communities/all/moderators/new")).to route_to(controller: "moderators", action: "new", community_id: "all")
  end

  it "routes POST /communities/all/moderators to moderators#create" do
    expect(post("/communities/all/moderators")).to route_to(controller: "moderators", action: "create", community_id: "all")
  end

  it "routes GET /communities/all/moderators/1/edit to page_not_found#show" do
    expect(get("/communities/all/moderators/1/edit")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/moderators/1/edit")
  end

  it "routes PUT /communities/all/moderators/1 to page_not_found#show" do
    expect(put("/communities/all/moderators/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/moderators/1")
  end

  it "routes PATCH /communities/all/moderators/1 to page_not_found#show" do
    expect(patch("/communities/all/moderators/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/moderators/1")
  end

  it "routes DELETE /communities/all/moderators/1 to moderators#destroy" do
    expect(delete("/communities/all/moderators/1")).to route_to(controller: "moderators", action: "destroy", community_id: "all", id: "1")
  end
end