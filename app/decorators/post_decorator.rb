# frozen_string_literal: true

class PostDecorator < ApplicationDecorator
  include ApprovableDecorator
  include RemovableDecorator
  include ReportableDecorator
  include VotableDecorator
  include BookmarkableDecorator
  include CommentableDecorator

  def created_at
    h.datetime_ago_tag(model.created_at)
  end

  def edited_at
    edited_at = h.datetime_ago_tag(model.edited_at)

    h.t('edited_html', edited_at: edited_at)
  end

  def content_processing?
    model.media_attacher.cached?
  end

  def content_processing_message
    h.t("content_processing")
  end

  def edit_link
    link_title = h.t("edit")
    link_path = [:edit, model]
    link_class = "dropdown-item"

    h.link_to(link_title, link_path, class: link_class)
  end

  def spoiler_link
    spoiler = model.spoiler?

    link_title = spoiler ? h.fa_icon('check-square-o', text: h.t('spoiler')) : h.fa_icon('square-o', text: h.t('spoiler'))
    link_class = "spoiler dropdown-item"
    link_data_params = "update_post[spoiler]=#{spoiler ? false : true}"
    link_path = [model]

    h.link_to(link_title, link_path, data: { params: link_data_params }, remote: true, method: :put, class: link_class)
  end

  def explicit_link
    explicit = model.explicit?

    link_title = explicit ? h.fa_icon('check-square-o', text: h.t('explicit')) : h.fa_icon('square-o', text: h.t('explicit'))
    link_class = "explicit dropdown-item"
    link_data_params = "update_post[explicit]=#{explicit ? false : true}"
    link_path = [model]

    h.link_to(link_title, link_path, data: { params: link_data_params }, remote: true, method: :put, class: link_class)
  end

  def content_partial
    if model.text?
      "posts/content/text_content"
    elsif model.url?
      if model.youtube?
        "posts/content/link_youtube_content"
      else
        "posts/content/link_content"
      end
    elsif model.media?
      if model.media_attacher.cached?
        "posts/content/media_processing"
      else
        if model.image?
          "posts/content/media_image_content"
        elsif model.video?
          "posts/content/media_video_content"
        elsif model.gif?
          "posts/content/media_gif_content"
        end
      end
    end
  end

  def preview_partial
    if model.text?
      "posts/content/text_preview"
    elsif model.url?
      if model.youtube?
        "posts/content/link_youtube_preview"
      else
        "posts/content/link_content"
      end
    elsif model.media?
      if model.media_attacher.cached?
        "posts/content/media_processing"
      else
        if model.image?
          "posts/content/media_image_preview"
        elsif model.video?
          "posts/content/media_video_preview"
        elsif model.gif?
          "posts/content/media_gif_preview"
        end
      end
    end
  end
end
