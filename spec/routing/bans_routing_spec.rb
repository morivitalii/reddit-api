require "rails_helper"

RSpec.describe "routes for BansController", type: :routing do
  it "routes GET /communities/all/bans to bans#index" do
    expect(get("/communities/all/bans")).to route_to(controller: "bans", action: "index", community_id: "all")
  end

  it "routes GET /communities/all/bans/1 to page_not_found#show" do
    expect(get("/communities/all/bans/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/bans/1")
  end

  it "routes GET /communities/all/bans/new to bans#new" do
    expect(get("/communities/all/bans/new")).to route_to(controller: "bans", action: "new", community_id: "all")
  end

  it "routes POST /communities/all/bans to bans#create" do
    expect(post("/communities/all/bans")).to route_to(controller: "bans", action: "create", community_id: "all")
  end

  it "routes GET /communities/all/bans/1/edit to bans#edit" do
    expect(get("/communities/all/bans/1/edit")).to route_to(controller: "bans", action: "edit", community_id: "all", id: "1")
  end

  it "routes PUT /communities/all/bans/1 to bans#update" do
    expect(put("/communities/all/bans/1")).to route_to(controller: "bans", action: "update", community_id: "all", id: "1")
  end

  it "routes PATCH /communities/all/bans/1 to bans#update" do
    expect(patch("/communities/all/bans/1")).to route_to(controller: "bans", action: "update", community_id: "all", id: "1")
  end

  it "routes DELETE /communities/all/bans/1 to bans#destroy" do
    expect(delete("/communities/all/bans/1")).to route_to(controller: "bans", action: "destroy", community_id: "all", id: "1")
  end
end