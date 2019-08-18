require "rails_helper"

RSpec.describe "routes for PasswordController", type: :routing do
  it "routes GET /password to page_not_found#show" do
    expect(get("/password")).to route_to(controller: "page_not_found", action: "show", path: "password")
  end

  it "routes GET /password/new to page_not_found#show" do
    expect(get("/password/new")).to route_to(controller: "page_not_found", action: "show", path: "password/new")
  end

  it "routes POST /password to page_not_found#show" do
    expect(post("/password")).to route_to(controller: "page_not_found", action: "show", path: "password")
  end

  it "routes GET /password/edit to password#edit" do
    expect(get("/password/edit")).to route_to(controller: "password", action: "edit")
  end

  it "routes PUT /password to password#update" do
    expect(put("/password")).to route_to(controller: "password", action: "update")
  end

  it "routes PATCH /password to password#update" do
    expect(patch("/password")).to route_to(controller: "password", action: "update")
  end

  it "routes DELETE /password to page_not_found#show" do
    expect(delete("/password")).to route_to(controller: "page_not_found", action: "show", path: "password")
  end
end