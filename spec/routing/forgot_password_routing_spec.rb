require "rails_helper"

RSpec.describe "routes for ForgotPasswordController", type: :routing do
  it "routes GET /forgot_password to page_not_found#show" do
    expect(get("/forgot_password")).to route_to(controller: "page_not_found", action: "show", path: "forgot_password")
  end

  it "routes GET /forgot_password/new to forgot_password#new" do
    expect(get("/forgot_password/new")).to route_to(controller: "forgot_password", action: "new")
  end

  it "routes POST /forgot_password to forgot_password#create" do
    expect(post("/forgot_password")).to route_to(controller: "forgot_password", action: "create")
  end

  it "routes GET /forgot_password/edit to page_not_found#show" do
    expect(get("/forgot_password/edit")).to route_to(controller: "page_not_found", action: "show", path: "forgot_password/edit")
  end

  it "routes PUT /forgot_password to page_not_found#show" do
    expect(put("/forgot_password")).to route_to(controller: "page_not_found", action: "show", path: "forgot_password")
  end

  it "routes PATCH /forgot_password to page_not_found#show" do
    expect(patch("/forgot_password")).to route_to(controller: "page_not_found", action: "show", path: "forgot_password")
  end

  it "routes DELETE /forgot_password to page_not_found#show" do
    expect(delete("/forgot_password")).to route_to(controller: "page_not_found", action: "show", path: "forgot_password")
  end
end