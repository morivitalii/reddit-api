require "rails_helper"

RSpec.describe "routes for UsersController", type: :routing do
  it "routes GET /users to page_not_found#show" do
    expect(get("/users")).to route_to(controller: "page_not_found", action: "show", path: "users")
  end

  it "routes GET /users to users#posts" do
    expect(get("/users/username/posts")).to route_to(controller: "users", action: "posts", id: "username")
  end

  it "routes GET /users to users#comments" do
    expect(get("/users/username/comments")).to route_to(controller: "users", action: "comments", id: "username")
  end

  it "routes GET /users/username to page_not_found#show" do
    expect(get("/users/username")).to route_to(controller: "page_not_found", action: "show", path: "users/username")
  end

  it "routes GET /users/new to page_not_found#show" do
    expect(get("/users/new")).to route_to(controller: "page_not_found", action: "show", path: "users/new")
  end

  it "routes POST /users to page_not_found#show" do
    expect(post("/users")).to route_to(controller: "page_not_found", action: "show", path: "users")
  end

  it "routes GET /users/edit to users#edit" do
    expect(get("/users/edit")).to route_to(controller: "users", action: "edit")
  end

  it "routes PUT /users to users#update" do
    expect(put("/users")).to route_to(controller: "users", action: "update")
  end

  it "routes PATCH /users to users#update" do
    expect(patch("/users")).to route_to(controller: "users", action: "update")
  end

  it "routes DELETE /users/username to page_not_found#show" do
    expect(delete("/users/username")).to route_to(controller: "page_not_found", action: "show", path: "users/username")
  end
end