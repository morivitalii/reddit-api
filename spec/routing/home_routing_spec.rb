require "rails_helper"

RSpec.describe "routes for HomeController", type: :routing do
  it "routes GET / to home#index" do
    expect(get("/")).to route_to("home#index")
  end
end