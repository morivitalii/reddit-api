# frozen_string_literal: true

class ThingPresenter < ApplicationPresenter
  def score
    helpers.number_to_human(top_score, separator: ".", strip_insignificant_zeros: true, units: { thousand: "k" }, format: "%n%u")
  end

  def comments_count
    "#{helpers.number_to_human(__getobj__.comments_count, separator: '.', strip_insignificant_zeros: true, units: { thousand: 'k' })} #{I18n.translate('comments_count', count: __getobj__.comments_count)}"
  end

  def content
    if post? && text?
      "posts/content/text_content"
    elsif link?
      if youtube?
        "posts/content/link_youtube_content"
      else
        "posts/content/link_content"
      end
    elsif media?
      if file_attacher.cached?
        "posts/content/media_processing"
      else
        if image?
          "posts/content/media_image_content"
        elsif video?
          "posts/content/media_video_content"
        elsif gif?
          "posts/content/media_gif_content"
        end
      end
    elsif comment? && text?
      "posts/content/comment_content"
    end
  end

  def preview
    if post? && text?
      "things/content/text_preview"
    elsif link?
      if youtube?
        "things/content/link_youtube_preview"
      else
        "things/content/link_content"
      end
    elsif media?
      if file_attacher.cached?
        "things/content/media_processing"
      else
        if image?
          "things/content/media_image_preview"
        elsif video?
          "things/content/media_video_preview"
        elsif gif?
          "things/content/media_gif_preview"
        end
      end
    elsif comment? && text?
      "things/content/comment_preview"
    end
  end
end
