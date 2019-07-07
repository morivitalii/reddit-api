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

  def thing_date_filter_options
    { day: t("day"), week: t("week"), month: t("month"), all: t("all_time") }.with_indifferent_access
  end

  def thing_date_filter(param)
    case param
    when "day" then 1.day.ago
    when "week" then 1.week.ago
    when "month" then 1.month.ago
    end
  end

  def thing_sort_filter_options
    { hot: t("hot"), new: t("new"), top: t("top"), controversy: t("controversy") }.with_indifferent_access
  end

  def thing_sort_filter(param)
    case param
    when "hot" then :hot
    when "top" then :top
    when "new" then :created_at
    when "controversy" then :controversy
    end
  end

  def thing_type_filter_options
    { all: t("posts_and_comments"), posts: t("posts"), comments: t("comments") }.with_indifferent_access
  end

  def thing_type_filter(param)
    case param
    when "posts" then :post
    when "comments" then :comment
    end
  end

  def mod_queue_filter_options
    { all: t("all"), new: t("new"), reports: t("reports") }.with_indifferent_access
  end

  def mod_queue_filter(param)
    case param
    when "new" then :not_approved
    when "reports" then :reported
    end
  end

  def vote_type_filter_options
    { all: t("ups_and_downs"), ups: t("ups"), downs: t("downs") }.with_indifferent_access
  end

  def vote_type_filter(param)
    case param
    when "ups" then :up
    when "downs" then :down
    end
  end

  def sub_mod_menu(sub)
    menu = {
      t("mod_queue") => sub_mod_queue_path(sub),
      t("moderators") => sub_moderators_path(sub),
      t("bans") => sub_bans_path(sub),
      t("contributors") => sub_contributors_path(sub)
    }

    if SubRulePolicy.new(current_user, sub).index?
      menu[t("rules")] = sub_rules_path(sub)
    end

    if SubDeletionReasonPolicy.new(current_user, sub).index?
      menu[t("deletion_reasons")] = sub_deletion_reasons_path(sub)
    end

    if SubTagPolicy.new(current_user, sub).index?
      menu[t("tags")] = sub_tags_path(sub)
    end

    menu[t("pages")] = sub_pages_path(sub)

    if SubBlacklistedDomainPolicy.new(current_user, sub).index?
      menu[t("blacklisted_domains")] = sub_blacklisted_domains_path(sub)
    end

    if SubLogPolicy.new(current_user, sub).index?
      menu[t("logs")] = sub_logs_path(sub)
    end

    if SubPolicy.new(current_user, sub).update?
      menu[t("settings")] = edit_sub_path(sub)
    end

    menu
  end

  def user_profile_menu(user)
    menu = {
      t("posts_and_comments") => user_path(user, thing_type: :all),
      t("posts") => user_path(user, thing_type: :posts),
      t("comments") =>user_path(user, thing_type: :comments)
    }

    if Current.user&.id == user.id
      menu[t("notifications")] = user_notifications_path(user)
    end

    if UserBookmarksPolicy.new(current_user, user).index?
      menu[t("bookmarks")] = user_bookmarks_path(user)
    end

    if UserVotesPolicy.new(current_user, user).index?
      menu[t("votes")] = user_votes_path(user)
    end

    menu
  end
end
