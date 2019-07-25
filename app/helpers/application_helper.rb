# frozen_string_literal: true

module ApplicationHelper
  def user_signed_in?
    request.env["warden"].user.present?
  end

  def user_not_signed_in?
    !user_signed_in?
  end

  def datetime_tag(time, format)
    content_tag("span", "", class: "datetime-#{format}", data: { timestamp: time.to_i })
  end

  def user_profile_menu(user)
    menu = {
      t("posts_and_comments") => user_path(user, type: :all),
      t("posts") => user_path(user, type: :post),
      t("comments") =>user_path(user, type: :comment)
    }

    if Current.user&.id == user.id
      menu[t("notifications")] = notifications_path
    end

    if BookmarkPolicy.new(pundit_user, nil).index?
      menu[t("bookmarks")] = bookmarks_path
    end

    if VotePolicy.new(pundit_user, nil).index?
      menu[t("votes")] = votes_path
    end

    menu
  end
end
