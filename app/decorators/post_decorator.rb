# frozen_string_literal: true

class PostDecorator < ApplicationDecorator
  def comments_link
    comments_count = model.comments_count
    comments_pluralized = h.t('comments_count', count: comments_count)
    link_title = "#{h.number_to_human(comments_count, separator: '.', strip_insignificant_zeros: true, units: { thousand: 'k' })} #{comments_pluralized}"
    link_path = [model]
    link_class = "comments_count"

    h.link_to(link_title, link_path, class: link_class)
  end

  def created_at
    h.datetime_ago_tag(model.created_at)
  end

  def edited_at
    edited_at = h.datetime_ago_tag(model.edited_at)

    h.t('edited_html', edited_at: edited_at)
  end

  def up_vote_link
    up_voted = model.vote&.up?

    link_class = up_voted ? "up text-success mr-1p" : "up mr-1"
    link_icon = h.fa_icon("arrow-up")
    link_path = [model, :votes]
    link_data_params = up_voted ? "" : "create_vote_form[type]=up"
    link_method = up_voted ? :delete : :post

    h.link_to(link_icon, link_path, data: { params: link_data_params }, remote: true, method: link_method, class: link_class)
  end

  def score
    score = h.number_to_human(model.score, separator: ".", strip_insignificant_zeros: true, units: { thousand: "k" }, format: "%n%u")

    h.content_tag(:span, score, class: "score")
  end

  def down_vote_link
    down_voted = model.vote&.down?

    link_class = down_voted ? "down text-danger mr-1" : "down mr-1"
    link_icon = h.fa_icon("arrow-down")
    link_path = [model, :votes]
    link_data_params = down_voted ? "" : "create_vote_form[type]=down"
    link_method = down_voted ? :delete : :post

    h.link_to(link_icon, link_path, data: { params: link_data_params }, remote: true, method: link_method, class: link_class)
  end

  def content_processing?
    model.media_attacher.cached?
  end

  def content_processing_message
    h.t("content_processing")
  end

  def approve_link
    approved = model.approved?

    link_icon = h.fa_icon('check')
    link_class = approved ? "approve text-success" : "approve"
    link_path = [:approve, model]

    if approved
      approved_by_user = model.approved_by.username
      approved_at = h.l(model.approved_at)

      link_tooltip_message = h.t('approved_details', username: approved_by_user, approved_at: approved_at)
    else
      link_tooltip_message = h.t('approve')
    end

    h.link_to(link_icon, link_path, remote: true, method: :post, class: link_class, data: { toggle: :tooltip }, title: link_tooltip_message)
  end

  def bookmark_link
    bookmarked = model.bookmark.present?

    link_icon = bookmarked ? h.fa_icon('bookmark') : h.fa_icon('bookmark-o')
    link_path = [model, :bookmarks]
    link_method = bookmarked ? :delete : :post
    link_class = "bookmark"
    link_tooltip_message = bookmarked ? h.t('delete_bookmark') : h.t('bookmark')

    h.link_to(link_icon, link_path, remote: true, method: link_method, class: link_class, title: link_tooltip_message, data: { toggle: :tooltip })
  end

  def remove_link
    removed = model.removed?

    link_icon = h.fa_icon("trash")
    link_path = [:remove, model]
    link_class = removed ? "remove text-danger" : "remove"

    if removed
      username = model.removed_by.username
      reason = model.removed_reason
      removed_at = h.l(model.removed_at)

      link_tooltip_message = h.t("deletion_details", username: username, removed_at: removed_at, reason: reason)
    else
      link_tooltip_message = h.t("delete")
    end

    h.link_to(link_icon, link_path, remote: true, class: link_class, data: { toggle: :tooltip }, title: link_tooltip_message)
  end

  def removed_message
    removed_by = model.removed_by
    removed_at = h.datetime_ago_tag(model.removed_at)
    reason = model.removed_reason

    link_to_user_profile = h.link_to(removed_by.username, h.posts_user_path(removed_by))

    h.t("removed_html", username: link_to_user_profile, removed_at: removed_at, reason: reason)
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

  def report_link
    link_title = h.t('report')
    link_path = [:new, model, :report]
    link_class = "report dropdown-item"

    h.link_to(link_title, link_path, remote: true, class: link_class)
  end

  def reports_link
    link_title = h.t('reports')
    link_path = [model, :reports]
    link_class = "reports dropdown-item"

    h.link_to(link_title, link_path, remote: true, class: link_class)
  end

  def ignore_reports_link
    ignore_reports = model.ignore_reports?
    model_name = model.class.name.camelize(:lower)

    link_title = ignore_reports ? h.fa_icon('check-square-o', text: h.t('ignore_reports')) : h.fa_icon('square-o', text: h.t('ignore_reports'))
    link_class = "ignore_reports dropdown-item"
    link_data_params = "update_#{model_name}[ignore_reports]=#{ignore_reports ? false : true}"
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
