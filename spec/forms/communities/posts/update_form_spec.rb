require "rails_helper"

RSpec.describe Communities::Posts::UpdateForm do
  it "updates post" do
    form = build_update_post_form

    form.save

    post = form.post
    expect(post.text).to eq(form.text)
  end

  def build_update_post_form
    post = create(:post)
    user = create(:user)

    described_class.new(post: post, user: user, text: "Text")
  end
end
