require "rails_helper"

RSpec.describe "routes for VotesController", type: :routing do
  # users

  it "routes GET /users/username/votes to page_not_found#show" do
    expect(get("/users/username/votes")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes")
  end

  it "routes GET /users/username/votes/1 to page_not_found#show" do
    expect(get("/users/username/votes/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes/1")
  end

  it "routes GET /users/username/votes/new to page_not_found#show" do
    expect(get("/users/username/votes/new")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes/new")
  end

  it "routes POST /users/username/votes to page_not_found#show" do
    expect(post("/users/username/votes")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes")
  end

  it "routes GET /users/username/votes/1/edit to page_not_found#show" do
    expect(get("/users/username/votes/1/edit")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes/1/edit")
  end

  it "routes PUT /users/username/votes/1 to page_not_found#show" do
    expect(put("/users/username/votes/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes/1")
  end

  it "routes PATCH /users/username/votes/1 to page_not_found#show" do
    expect(patch("/users/username/votes/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes/1")
  end

  it "routes DELETE /users/username/votes/1 to page_not_found#show" do
    expect(delete("/users/username/votes/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/votes/1")
  end

  # posts

  it "routes GET /posts/1/votes to page_not_found#show" do
    expect(get("/posts/1/votes")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/votes")
  end

  it "routes GET /posts/1/votes/new to page_not_found#show" do
    expect(get("/posts/1/votes/new")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/votes/new")
  end

  it "routes POST /posts/1/votes to votes#create" do
    expect(post("/posts/1/votes")).to route_to(controller: "votes", action: "create", post_id: "1")
  end

  it "routes GET /posts/1/votes/edit to page_not_found#show" do
    expect(get("/posts/1/votes/edit")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/votes/edit")
  end

  it "routes PUT /posts/1/votes to page_not_found#show" do
    expect(put("/posts/1/votes")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/votes")
  end

  it "routes PATCH /posts/1/votes to page_not_found#show" do
    expect(patch("/posts/1/votes")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/votes")
  end

  it "routes DELETE /posts/1/votes to votes#destroy" do
    expect(delete("/posts/1/votes")).to route_to(controller: "votes", action: "destroy", post_id: "1")
  end

  # comments

  it "routes GET /comments/1/votes to page_not_found#show" do
    expect(get("/comments/1/votes")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/votes")
  end

  it "routes GET /comments/1/votes/new to page_not_found#show" do
    expect(get("/comments/1/votes/new")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/votes/new")
  end

  it "routes POST /comments/1/votes to votes#create" do
    expect(post("/comments/1/votes")).to route_to(controller: "votes", action: "create", comment_id: "1")
  end

  it "routes GET /comments/1/votes/edit to page_not_found#show" do
    expect(get("/comments/1/votes/edit")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/votes/edit")
  end

  it "routes PUT /comments/1/votes to page_not_found#show" do
    expect(put("/comments/1/votes")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/votes")
  end

  it "routes PATCH /comments/1/votes to page_not_found#show" do
    expect(patch("/comments/1/votes")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/votes")
  end

  it "routes DELETE /comments/1/votes to votes#destroy" do
    expect(delete("/comments/1/votes")).to route_to(controller: "votes", action: "destroy", comment_id: "1")
  end
end