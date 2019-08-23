require "rails_helper"

RSpec.describe "routes for mod_queuesController", type: :routing do
  it "routes GET /communities/all/mod_queues/new_posts to mod_queues#new_posts_index" do
    expect(get("/communities/all/mod_queues/new_posts")).to route_to(controller: "mod_queues", action: "new_posts_index", community_id: "all")
  end

  it "routes GET /communities/all/mod_queues/new_comments to mod_queues#new_comments_index" do
    expect(get("/communities/all/mod_queues/new_comments")).to route_to(controller: "mod_queues", action: "new_comments_index", community_id: "all")
  end

  it "routes GET /communities/all/mod_queues/reported_posts to mod_queues#reported_posts_index" do
    expect(get("/communities/all/mod_queues/reported_posts")).to route_to(controller: "mod_queues", action: "reported_posts_index", community_id: "all")
  end

  it "routes GET /communities/all/mod_queues/reported_comments to mod_queues#reported_comments_index" do
    expect(get("/communities/all/mod_queues/reported_comments")).to route_to(controller: "mod_queues", action: "reported_comments_index", community_id: "all")
  end

  it "routes GET /communities/all/mod_queues to page_not_found#show" do
    expect(get("/communities/all/mod_queues")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues")
  end

  it "routes GET /communities/all/mod_queues/1 to page_not_found#show" do
    expect(get("/communities/all/mod_queues/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues/1")
  end

  it "routes GET /communities/all/mod_queues/new to page_not_found#show" do
    expect(get("/communities/all/mod_queues/new")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues/new")
  end

  it "routes POST /communities/all/mod_queues to page_not_found#show" do
    expect(post("/communities/all/mod_queues")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues")
  end

  it "routes GET /communities/all/mod_queues/1/edit to page_not_found#show" do
    expect(get("/communities/all/mod_queues/1/edit")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues/1/edit")
  end

  it "routes PUT /communities/all/mod_queues/1 to page_not_found#show" do
    expect(put("/communities/all/mod_queues/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues/1")
  end

  it "routes PATCH /communities/all/mod_queues/1 to page_not_found#show" do
    expect(patch("/communities/all/mod_queues/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues/1")
  end

  it "routes DELETE /communities/all/mod_queues/1 to page_not_found#show" do
    expect(delete("/communities/all/mod_queues/1")).to route_to(controller: "page_not_found", action: "show", path: "communities/all/mod_queues/1")
  end
end