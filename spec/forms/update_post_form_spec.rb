require "rails_helper"

RSpec.describe UpdatePostForm do
  it { expect(described_class.new).to be_persisted }

  it "updates post" do
    form = build_update_post_form

    form.save

    post = form.post
    expect(post.text).to eq(form.text)
    expect(post.explicit).to eq(form.explicit)
    expect(post.spoiler).to eq(form.spoiler)
    expect(post.ignore_reports).to eq(form.ignore_reports)
  end

  it "remove attributes with nil values before update" do
    form = build_update_post_form
    form.text = nil
    form.explicit = nil
    form.spoiler = nil
    form.ignore_reports = nil

    form.save

    post = form.post
    expect(post.text).to_not be_blank
    expect(post.explicit).to_not be_nil
    expect(post.spoiler).to_not be_nil
    expect(post.ignore_reports).to_not be_nil
  end

  def build_update_post_form
    post = create(:post)
    user = create(:user)

    described_class.new(post: post, user: user, text: "Text", explicit: true, spoiler: true, ignore_reports: true)
  end
end
