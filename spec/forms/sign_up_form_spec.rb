require "rails_helper"

RSpec.describe SignUpForm do
  it { expect(described_class.new).to_not be_persisted }

  describe ".save" do
    it "creates user" do
      form = build_sign_up_form

      form.save

      user = form.user
      expect(user).to be_persisted
      expect(user.username).to eq(form.username)
      expect(user.password).to eq(form.password)
      expect(user.email).to eq(form.email)
    end
  end

  def build_sign_up_form
    described_class.new(
      username: "username",
      password: "password",
      email: "email@email.com"
    )
  end
end
