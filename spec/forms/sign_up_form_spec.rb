require "rails_helper"

RSpec.describe SignUpForm do
  subject { described_class }

  describe ".save" do
    context "valid" do
      before do
        @attributes = { username: "username", email: "email@emal.com", password: "password" }
        @form = subject.new(@attributes)
      end

      it "creates user" do
        @form.save

        expect(@form.user).to be_persisted
        expect(@form.user).to have_attributes(@attributes)
      end
    end
  end
end