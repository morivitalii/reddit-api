require "rails_helper"

RSpec.describe "routes for BookmarksController", type: :routing do
  # users

  it "routes GET /users/username/bookmarks/posts to bookmarks#posts_index" do
    expect(get("/users/username/bookmarks/posts")).to route_to(controller: "bookmarks", action: "posts_index", user_id: "username")
  end

  it "routes GET /users/username/bookmarks/comments to bookmarks#comments_index" do
    expect(get("/users/username/bookmarks/comments")).to route_to(controller: "bookmarks", action: "comments_index", user_id: "username")
  end

  it "routes GET /users/username/bookmarks to page_not_found#show" do
    expect(get("/users/username/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks")
  end

  it "routes GET /users/username/bookmarks/1 to page_not_found#show" do
    expect(get("/users/username/bookmarks/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks/1")
  end

  it "routes GET /users/username/bookmarks/new to page_not_found#show" do
    expect(get("/users/username/bookmarks/new")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks/new")
  end

  it "routes POST /users/username/bookmarks to page_not_found#show" do
    expect(post("/users/username/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks")
  end

  it "routes GET /users/username/bookmarks/1/edit to page_not_found#show" do
    expect(get("/users/username/bookmarks/1/edit")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks/1/edit")
  end

  it "routes PUT /users/username/bookmarks/1 to page_not_found#show" do
    expect(put("/users/username/bookmarks/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks/1")
  end

  it "routes PATCH /users/username/bookmarks/1 to page_not_found#show" do
    expect(patch("/users/username/bookmarks/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks/1")
  end

  it "routes DELETE /users/username/bookmarks/1 to page_not_found#show" do
    expect(delete("/users/username/bookmarks/1")).to route_to(controller: "page_not_found", action: "show", path: "users/username/bookmarks/1")
  end

  # posts

  it "routes GET /posts/1/bookmarks to page_not_found#show" do
    expect(get("/posts/1/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/bookmarks")
  end

  it "routes GET /posts/1/bookmarks/new to page_not_found#show" do
    expect(get("/posts/1/bookmarks/new")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/bookmarks/new")
  end

  it "routes POST /posts/1/bookmarks to bookmarks#create" do
    expect(post("/posts/1/bookmarks")).to route_to(controller: "bookmarks", action: "create", post_id: "1")
  end

  it "routes GET /posts/1/bookmarks/edit to page_not_found#show" do
    expect(get("/posts/1/bookmarks/edit")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/bookmarks/edit")
  end

  it "routes PUT /posts/1/bookmarks to page_not_found#show" do
    expect(put("/posts/1/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/bookmarks")
  end

  it "routes PATCH /posts/1/bookmarks to page_not_found#show" do
    expect(patch("/posts/1/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/bookmarks")
  end

  it "routes DELETE /posts/1/bookmarks to bookmarks#destroy" do
    expect(delete("/posts/1/bookmarks")).to route_to(controller: "bookmarks", action: "destroy", post_id: "1")
  end

  # comments

  it "routes GET /comments/1/bookmarks to page_not_found#show" do
    expect(get("/comments/1/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/bookmarks")
  end

  it "routes GET /comments/1/bookmarks/new to page_not_found#show" do
    expect(get("/comments/1/bookmarks/new")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/bookmarks/new")
  end

  it "routes POST /comments/1/bookmarks to bookmarks#create" do
    expect(post("/comments/1/bookmarks")).to route_to(controller: "bookmarks", action: "create", comment_id: "1")
  end

  it "routes GET /comments/1/bookmarks/edit to page_not_found#show" do
    expect(get("/comments/1/bookmarks/edit")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/bookmarks/edit")
  end

  it "routes PUT /comments/1/bookmarks to page_not_found#show" do
    expect(put("/comments/1/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/bookmarks")
  end

  it "routes PATCH /comments/1/bookmarks to page_not_found#show" do
    expect(patch("/comments/1/bookmarks")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/bookmarks")
  end

  it "routes DELETE /comments/1/bookmarks to bookmarks#destroy" do
    expect(delete("/comments/1/bookmarks")).to route_to(controller: "bookmarks", action: "destroy", comment_id: "1")
  end
end