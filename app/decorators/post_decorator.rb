class PostDecorator < ApplicationDecorator
  def comments_link
    h.link_to(
      comments_count,
      h.community_post_path(model.community, model),
      class: "post__comments-link"
    )
  end

  def comments_count_text
    h.content_tag("span", comments_count, class: "post__comments-count")
  end

  def comments_count
    comments_count = model.comments_count
    comments_count_formatted = h.number_to_human(comments_count, separator: ".", strip_insignificant_zeros: true, units: {thousand: "k"})

    h.t("communities.posts.post.comments_count", count: comments_count, count_formatted: comments_count_formatted)
  end

  def created_at
    h.datetime_ago_tag(model.created_at)
  end

  def edited_at
    edited_at = h.datetime_ago_tag(model.edited_at)

    h.t("communities.posts.post.edited_at_html", edited_at: edited_at)
  end

  def url_title
    h.truncate(model.url, length: 40)
  end

  def up_vote_link
    up_voted = model.vote&.up?

    h.link_to(
      h.fa_icon("arrow-up"),
      h.community_post_vote_up_path(model.community, model),
      remote: true,
      method: up_voted ? :delete : :post,
      class: up_voted ? "post__up-vote-link post__up-vote-link_up-voted" : "post__up-vote-link"
    )
  end

  def score
    score = h.number_to_human(model.score, separator: ".", strip_insignificant_zeros: true, units: {thousand: "k"}, format: "%n%u")

    h.content_tag(:span, score, class: "post__score")
  end

  def down_vote_link
    down_voted = model.vote&.down?

    h.link_to(
      h.fa_icon("arrow-down"),
      h.community_post_vote_down_path(model.community, model),
      remote: true,
      method: down_voted ? :delete : :post,
      class: down_voted ? "post__down-vote-link post__down-vote-link_down-voted" : "post__down-vote-link"
    )
  end

  def approve_link
    approved = model.approved?

    if approved
      approved_by_user = model.approved_by.username
      approved_at = h.l(model.approved_at)

      tooltip_message = h.t("communities.posts.post.approved_tooltip", username: approved_by_user, approved_at: approved_at)
    else
      tooltip_message = h.t("communities.posts.post.approve_tooltip")
    end

    h.link_to(
      h.fa_icon("check"),
      h.community_post_approve_path(model.community, model),
      remote: true,
      method: :put,
      class: approved ? "post__approve-link post__approve-link_approved" : "post__approve-link",
      data: {toggle: :tooltip},
      title: tooltip_message
    )
  end

  def bookmark_link
    bookmarked = model.bookmark.present?

    h.link_to(
      bookmarked ? h.fa_icon("bookmark") : h.fa_icon("bookmark-o"),
      h.community_post_bookmarks_path(model.community, model),
      remote: true,
      method: bookmarked ? :delete : :post,
      class: "post__bookmark-link",
      title: bookmarked ? h.t("communities.posts.post.delete_bookmark") : h.t("communities.posts.post.bookmark"),
      data: {toggle: :tooltip}
    )
  end

  def remove_link
    removed = model.removed?

    if removed
      username = model.removed_by.username
      reason = model.removed_reason
      removed_at = h.l(model.removed_at)

      link_tooltip_message = h.t("communities.posts.post.removed_tooltip", username: username, removed_at: removed_at, reason: reason)
    else
      link_tooltip_message = h.t("communities.posts.post.remove_tooltip")
    end

    h.link_to(
      h.fa_icon("trash"),
      h.edit_community_post_remove_path(model.community, model),
      remote: true,
      class: removed ? "post__remove-link post__remove-link_removed" : "post__remove-link",
      data: {toggle: :tooltip},
      title: link_tooltip_message
    )
  end

  def removed_message
    removed_by = model.removed_by
    removed_at = h.datetime_ago_tag(model.removed_at)
    reason = model.removed_reason

    link_to_user_profile = h.link_to(removed_by.username, h.user_posts_path(removed_by))

    h.t("communities.posts.post.removed_message_html", link_to_user_profile: link_to_user_profile, removed_at: removed_at, reason: reason)
  end

  def edit_link
    h.link_to(
      h.t("communities.posts.post.edit"),
      h.edit_community_post_path(model.community, model),
      class: "post__edit-link dropdown-item"
    )
  end

  def spoiler_link
    spoiler = model.spoiler?

    h.link_to(
      spoiler ? h.fa_icon("check-square-o", text: h.t("communities.posts.post.mark_spoiler")) : h.fa_icon("square-o", text: h.t("communities.posts.post.mark_spoiler")),
      h.community_post_spoiler_path(model.community, model),
      remote: true,
      method: spoiler ? :delete : :post,
      class: "post__spoiler-link dropdown-item"
    )
  end

  def explicit_link
    explicit = model.explicit?

    h.link_to(
      explicit ? h.fa_icon("check-square-o", text: h.t("communities.posts.post.mark_explicit")) : h.fa_icon("square-o", text: h.t("communities.posts.post.mark_explicit")),
      h.community_post_explicit_path(model.community, model),
      remote: true,
      method: explicit ? :delete : :post,
      class: "post__explicit-link dropdown-item"
    )
  end

  def report_link
    h.link_to(
      h.t("communities.posts.post.report"),
      h.new_community_post_report_path(model.community, model),
      remote: true,
      class: "post__report-link dropdown-item"
    )
  end

  def reports_link
    h.link_to(
      h.t("communities.posts.post.reports"),
      h.community_post_reports_path(model.community, model),
      remote: true,
      class: "post__reports-link dropdown-item"
    )
  end

  def ignore_reports_link
    ignore_reports = model.ignore_reports?

    h.link_to(
      ignore_reports ? h.fa_icon("check-square-o", text: h.t("communities.posts.post.ignore_reports")) : h.fa_icon("square-o", text: h.t("communities.posts.post.ignore_reports")),
      h.community_post_reports_ignore_path(model.community, model),
      remote: true,
      method: ignore_reports ? :delete : :post,
      class: "post__ignore-reports-link dropdown-item"
    )
  end
end
