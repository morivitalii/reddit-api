# frozen_string_literal: true

module ApplicationHelper
  def user_signed_in?
    request.env["warden"].user.present?
  end

  def user_not_signed_in?
    !user_signed_in?
  end

  def datetime_tag(time)
    content_tag("span", "", class: "datetime-ago", data: { timestamp: time.to_i })
  end

  def datetime_tag(time, format)
    content_tag("span", "", class: "datetime-#{format}", data: { timestamp: time.to_i })
  end

  def sub_mod_menu(sub)
    menu = {
      t("mod_queue") => mod_queue_path(sub: sub),
      t("moderators") => moderators_path(sub: sub),
      t("bans") => bans_path(sub: sub),
      t("contributors") => contributors_path(sub: sub)
    }

    if RulePolicy.new(pundit_user, sub).index?
      menu[t("rules")] = rules_path(sub: sub)
    end

    if DeletionReasonPolicy.new(pundit_user, sub).index?
      menu[t("deletion_reasons")] = deletion_reasons_path(sub: sub)
    end

    if TagPolicy.new(pundit_user, sub).index?
      menu[t("tags")] = tags_path(sub: sub)
    end

    menu[t("pages")] = pages_path(sub: sub)

    if BlacklistedDomainPolicy.new(pundit_user, BlacklistedDomain).index?
      menu[t("blacklisted_domains")] = blacklisted_domains_path(sub: sub)
    end

    if LogPolicy.new(pundit_user, sub).index?
      menu[t("logs")] = logs_path(sub: sub)
    end

    if SubPolicy.new(pundit_user, sub).update?
      menu[t("settings")] = edit_sub_path(sub)
    end

    menu
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
