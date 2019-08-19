require "rails_helper"

RSpec.describe "routes for reportsController", type: :routing do
  # posts

  it "routes GET /posts/1/reports to reports#index" do
    expect(get("/posts/1/reports")).to route_to(controller: "reports", action: "index", post_id: "1")
  end

  it "routes GET /posts/1/reports/1 to page_not_found#show" do
    expect(get("/posts/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/reports/1")
  end

  it "routes GET /posts/1/reports/new to reports#new" do
    expect(get("/posts/1/reports/new")).to route_to(controller: "reports", action: "new", post_id: "1")
  end

  it "routes POST /posts/1/reports to reports#create" do
    expect(post("/posts/1/reports")).to route_to(controller: "reports", action: "create", post_id: "1")
  end

  it "routes GET /posts/1/reports/1/edit to page_not_found#show" do
    expect(get("/posts/1/reports/1/edit")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/reports/1/edit")
  end

  it "routes PUT /posts/1/reports/1 to page_not_found#show" do
    expect(put("/posts/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/reports/1")
  end

  it "routes PATCH /posts/1/reports/1 to page_not_found#show" do
    expect(patch("/posts/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/reports/1")
  end

  it "routes DELETE /posts/1/reports/1 to page_not_found#show" do
    expect(delete("/posts/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "posts/1/reports/1")
  end

  # comments

  it "routes GET /comments/1/reports to reports#index" do
    expect(get("/comments/1/reports")).to route_to(controller: "reports", action: "index", comment_id: "1")
  end

  it "routes GET /comments/1/reports/1 to page_not_found#show" do
    expect(get("/comments/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/reports/1")
  end

  it "routes GET /comments/1/reports/new to reports#new" do
    expect(get("/comments/1/reports/new")).to route_to(controller: "reports", action: "new", comment_id: "1")
  end

  it "routes POST /comments/1/reports to reports#create" do
    expect(post("/comments/1/reports")).to route_to(controller: "reports", action: "create", comment_id: "1")
  end

  it "routes GET /comments/1/reports/1/edit to page_not_found#show" do
    expect(get("/comments/1/reports/1/edit")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/reports/1/edit")
  end

  it "routes PUT /comments/1/reports/1 to page_not_found#show" do
    expect(put("/comments/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/reports/1")
  end

  it "routes PATCH /comments/1/reports/1 to page_not_found#show" do
    expect(patch("/comments/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/reports/1")
  end

  it "routes DELETE /comments/1/reports/1 to page_not_found#show" do
    expect(delete("/comments/1/reports/1")).to route_to(controller: "page_not_found", action: "show", path: "comments/1/reports/1")
  end
end