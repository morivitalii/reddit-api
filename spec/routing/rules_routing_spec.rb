require "rails_helper"

RSpec.describe "routes for RulesController", type: :routing do
  it "routes GET /communities/all/rules to rules#index" do
    expect(get("/communities/all/rules")).to route_to(controller: "rules", action: "index", community_id: "all")
  end

  it "routes GET /communities/all/rules/1 to page_not_found#show" do
    expect(get("/communities/all/rules/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/rules/1")
  end

  it "routes GET /communities/all/rules/new to rules#new" do
    expect(get("/communities/all/rules/new")).to route_to(controller: "rules", action: "new", community_id: "all")
  end

  it "routes POST /communities/all/rules to rules#create" do
    expect(post("/communities/all/rules")).to route_to(controller: "rules", action: "create", community_id: "all")
  end

  it "routes GET /communities/all/rules/1/edit to rules#edit" do
    expect(get("/communities/all/rules/1/edit")).to route_to(controller: "rules", action: "edit", community_id: "all", id: "1")
  end

  it "routes PUT /communities/all/rules/1 to rules#update" do
    expect(put("/communities/all/rules/1")).to route_to(controller: "rules", action: "update", community_id: "all", id: "1")
  end

  it "routes PATCH /communities/all/rules/1 to rules#update" do
    expect(patch("/communities/all/rules/1")).to route_to(controller: "rules", action: "update", community_id: "all", id: "1")
  end

  it "routes DELETE /communities/all/rules/1 to rules#destroy" do
    expect(delete("/communities/all/rules/1")).to route_to(controller: "rules", action: "destroy", community_id: "all", id: "1")
  end
end