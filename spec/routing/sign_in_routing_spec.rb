require "rails_helper"

RSpec.describe "routes for SignInController", type: :routing do
  it "routes GET /sign_in to page_not_found#show" do
    expect(get("/sign_in")).to route_to(controller: "page_not_found", action: "show", path: "sign_in")
  end

  it "routes GET /sign_in/new to sign_in#new" do
    expect(get("/sign_in/new")).to route_to(controller: "sign_in", action: "new")
  end

  it "routes POST /sign_in to sign_in#create" do
    expect(post("/sign_in")).to route_to(controller: "sign_in", action: "create")
  end

  it "routes GET /sign_in/edit to page_not_found#show" do
    expect(get("/sign_in/edit")).to route_to(controller: "page_not_found", action: "show", path: "sign_in/edit")
  end

  it "routes PUT /sign_in to page_not_found#show" do
    expect(put("/sign_in")).to route_to(controller: "page_not_found", action: "show", path: "sign_in")
  end

  it "routes PATCH /sign_in to page_not_found#show" do
    expect(patch("/sign_in")).to route_to(controller: "page_not_found", action: "show", path: "sign_in")
  end

  it "routes DELETE /sign_in to page_not_found#show" do
    expect(delete("/sign_in")).to route_to(controller: "page_not_found", action: "show", path: "sign_in")
  end
end