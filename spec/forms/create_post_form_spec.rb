require "rails_helper"

RSpec.describe CreatePostForm do
  it { expect(described_class.new).to_not be_persisted }

  context "with text content" do
    it "creates post" do
      form = build_create_post_form_with_text

      expect { form.save }.to change { Post.count }.by(1)
    end
  end

  context "with link content" do
    it "creates post" do
      form = build_create_post_form_with_link

      expect { form.save }.to change { Post.count }.by(1)
    end
  end

  context "with image content" do
    it "creates post" do
      form = build_create_post_form_with_image

      expect { form.save }.to change { Post.count }.by(1)
    end
  end

  it "creates self upvote" do
    form = build_create_post_form_with_text

    expect { form.save }.to change { Vote.count }
  end

  def build_create_post_form_with_text
    form = build_create_post_form
    form.text = "Text"
    form
  end

  def build_create_post_form_with_link
    form = build_create_post_form
    form.url = "http://example.com/"
    form
  end

  def build_create_post_form_with_image
    form = build_create_post_form
    form.image = fixture_file_upload("files/post_image.jpg")
    form
  end

  def build_create_post_form
    community = create(:community)
    user = create(:user)
    described_class.new(community: community, user: user, title: "Title", explicit: false, spoiler: false)
  end
end