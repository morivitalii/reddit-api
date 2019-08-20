require "rails_helper"

RSpec.describe Community, type: :model do
  subject { described_class }

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