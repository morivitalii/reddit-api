require "rails_helper"

RSpec.describe Sub do
  subject { described_class }

  it_behaves_like "strip attributes", :title, :description, squish: true

  describe ".to_param" do
    it "returns url attribute" do
      url = "url"

      model = subject.new(url: url)
      expected_result = url
      result = model.url

      expect(result).to eq(expected_result)
    end
  end
end