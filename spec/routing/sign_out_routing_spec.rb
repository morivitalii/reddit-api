require "rails_helper"

RSpec.describe "routes for SignOutController", type: :routing do
  it "routes GET /sign_out to page_not_found#show" do
    expect(get("/sign_out")).to route_to(controller: "page_not_found", action: "show", path: "sign_out")
  end

  it "routes GET /sign_out/new to to page_not_found#show" do
    expect(get("/sign_out/new")).to route_to(controller: "page_not_found", action: "show", path: "sign_out/new")
  end

  it "routes POST /sign_out to to page_not_found#show" do
    expect(post("/sign_out")).to route_to(controller: "page_not_found", action: "show", path: "sign_out")
  end

  it "routes GET /sign_out/edit to page_not_found#show" do
    expect(get("/sign_out/edit")).to route_to(controller: "page_not_found", action: "show", path: "sign_out/edit")
  end

  it "routes PUT /sign_out to page_not_found#show" do
    expect(put("/sign_out")).to route_to(controller: "page_not_found", action: "show", path: "sign_out")
  end

  it "routes PATCH /sign_out to page_not_found#show" do
    expect(patch("/sign_out")).to route_to(controller: "page_not_found", action: "show", path: "sign_out")
  end

  it "routes DELETE /sign_out to sign_out#destroy" do
    expect(delete("/sign_out")).to route_to(controller: "sign_out", action: "destroy")
  end
end