class CommentDecorator < ApplicationDecorator
  def comments_link
    h.link_to(
      comments_count,
      h.comment_path(model),
      class: "comment__comments-link"
    )
  end

  def comments_count_text
    h.content_tag("span", comments_count, class: "comment__comments-count")
  end

  def comments_count
    comments_count = model.comments_count
    comments_count_formatted = h.number_to_human(comments_count, separator: ".", strip_insignificant_zeros: true, units: {thousand: "k"})

    h.t("comments.comment.comments_count", count: comments_count, count_formatted: comments_count_formatted)
  end

  def edited_at
    edited_at = h.datetime_ago_tag(model.edited_at)

    h.t("comments.comment.edited_at_html", edited_at: edited_at)
  end

  def up_vote_link
    up_voted = model.vote&.up?

    h.link_to(
      h.fa_icon("arrow-up"),
      h.community_post_comment_vote_up_path(model.community, model.post, model),
      data: {params: up_voted ? "" : "create_vote_form[type]=up"},
      remote: true,
      method: up_voted ? :delete : :comment,
      class: up_voted ? "comment__up-vote-link comment__up-vote-link_up-voted" : "comment__up-vote-link"
    )
  end

  def score
    score = h.number_to_human(model.score, separator: ".", strip_insignificant_zeros: true, units: {thousand: "k"}, format: "%n%u")

    h.content_tag(:span, score, class: "comment__score")
  end

  def down_vote_link
    down_voted = model.vote&.down?

    h.link_to(
      h.fa_icon("arrow-down"),
      h.community_post_comment_vote_down_path(model.community, model.post, model),
      data: {params: down_voted ? "" : "create_vote_form[type]=down"},
      remote: true,
      method: down_voted ? :delete : :comment,
      class: down_voted ? "comment__down-vote-link comment__down-vote-link_down-voted" : "comment__down-vote-link"
    )
  end

  def approve_link
    approved = model.approved?

    if approved
      approved_by_user = model.approved_by.username
      approved_at = h.l(model.approved_at)

      tooltip_message = h.t("comments.comment.approved_tooltip", username: approved_by_user, approved_at: approved_at)
    else
      tooltip_message = h.t("comments.comment.approve_tooltip")
    end

    h.link_to(
      h.fa_icon("check"),
      h.community_post_comment_approve_path(model.community, model.post, model),
      remote: true,
      method: :comment,
      class: approved ? "comment__approve-link comment__approve-link_approved" : "comment__approve-link",
      data: {toggle: :tooltip},
      title: tooltip_message
    )
  end

  def bookmark_link
    bookmarked = model.bookmark.present?

    h.link_to(
      bookmarked ? h.fa_icon("bookmark") : h.fa_icon("bookmark-o"),
      h.community_post_comment_bookmarks_path(model.community, model.post, model),
      remote: true,
      method: bookmarked ? :delete : :comment,
      class: "comment__bookmark-link",
      title: bookmarked ? h.t("comments.comment.delete_bookmark") : h.t("comments.comment.bookmark"),
      data: {toggle: :tooltip}
    )
  end

  def remove_link
    removed = model.removed?

    if removed
      username = model.removed_by.username
      reason = model.removed_reason
      removed_at = h.l(model.removed_at)

      link_tooltip_message = h.t("comments.comment.removed_tooltip", username: username, removed_at: removed_at, reason: reason)
    else
      link_tooltip_message = h.t("comments.comment.remove_tooltip")
    end

    h.link_to(
      h.fa_icon("trash"),
      h.community_post_comment_remove_path(model.community, model.post, model),
      remote: true,
      class: removed ? "comment__remove-link comment__remove-link_removed" : "comment__remove-link",
      data: {toggle: :tooltip},
      title: link_tooltip_message
    )
  end

  def removed_message
    removed_by = model.removed_by
    removed_at = h.datetime_ago_tag(model.removed_at)
    reason = model.removed_reason

    link_to_user_profile = h.link_to(removed_by.username, h.user_posts_path(removed_by))

    h.t("comments.comment.removed_message_html", link_to_user_profile: link_to_user_profile, removed_at: removed_at, reason: reason)
  end

  def report_link
    h.link_to(
      h.t("comments.comment.report"),
      h.new_community_post_comment_report_path(model.community, model.post, model),
      remote: true,
      class: "comment__report-link dropdown-item"
    )
  end

  def reports_link
    h.link_to(
      h.t("comments.comment.reports"),
      h.community_post_comment_reports_path(model.community, model.post, model),
      remote: true,
      class: "comment__reports-link dropdown-item"
    )
  end

  def ignore_reports_link
    ignore_reports = model.ignore_reports?

    h.link_to(
      ignore_reports ? h.fa_icon("check-square-o", text: h.t("communities.posts.post.ignore_reports")) : h.fa_icon("square-o", text: h.t("communities.posts.post.ignore_reports")),
      h.community_post_comment_reports_ignore_path(model.community, model.post, model),
      remote: true,
      method: ignore_reports ? :delete : :post,
      class: "comment__ignore-reports-link dropdown-item"
    )
  end
end
