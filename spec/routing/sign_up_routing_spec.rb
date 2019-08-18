require "rails_helper"

RSpec.describe "routes for SignUpController", type: :routing do
  it "routes GET /sign_up to page_not_found#show" do
    expect(get("/sign_up")).to route_to(controller: "page_not_found", action: "show", path: "sign_up")
  end

  it "routes GET /sign_up/new to sign_up#new" do
    expect(get("/sign_up/new")).to route_to(controller: "sign_up", action: "new")
  end

  it "routes POST /sign_up to sign_up#create" do
    expect(post("/sign_up")).to route_to(controller: "sign_up", action: "create")
  end

  it "routes GET /sign_up/edit to page_not_found#show" do
    expect(get("/sign_up/edit")).to route_to(controller: "page_not_found", action: "show", path: "sign_up/edit")
  end

  it "routes PUT /sign_up to page_not_found#show" do
    expect(put("/sign_up")).to route_to(controller: "page_not_found", action: "show", path: "sign_up")
  end

  it "routes PATCH /sign_up to page_not_found#show" do
    expect(patch("/sign_up")).to route_to(controller: "page_not_found", action: "show", path: "sign_up")
  end

  it "routes DELETE /sign_up to page_not_found#show" do
    expect(delete("/sign_up")).to route_to(controller: "page_not_found", action: "show", path: "sign_up")
  end
end