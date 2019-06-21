Rails.application.routes.draw do
  thing_sort_regex = /hot|new|top|controversy/
  thing_date_regex = /day|week|month/
  thing_type_regex = /posts|comments/
  vote_type_regex = /ups|downs/
  mod_queue_type_regex = /new|reports/

  concern :searchable do
    get "search", on: :collection
  end

  scope format: false do
    root "home#index", thing_sort: "hot", thing_date: "all"

    get "/:thing_sort(/:thing_date)", to: "home#index", as: :home, constraints: { thing_sort: thing_sort_regex, thing_date: thing_date_regex }, defaults: { thing_date: "all" }

    get "/sign_up", to: "sign_up#new", as: :sign_up_new
    post "/sign_up", to: "sign_up#create", as: :sign_up
    get "/sign_in", to: "sign_in#new", as: :sign_in_new
    post "/sign_in", to: "sign_in#create", as: :sign_in
    get "/forgot_password", to: "forgot_password#new", as: :forgot_password_new
    post "/forgot_password", to: "forgot_password#create", as: :forgot_password
    get "/new_password", to: "new_password#new", as: :new_password_new
    post "/new_password", to: "new_password#create", as: :new_password
    get "/sign_out", to: "sign_out#destroy", as: :sign_out
    get "/settings", to: "user_settings#edit", as: :user_settings_edit
    post "/settings", to: "user_settings#update", as: :user_settings

    get "/u/:username(/:thing_type)(/:thing_sort)(/:thing_date)", to: "users#show", as: :user, constraints: { thing_type: thing_type_regex, thing_sort: thing_sort_regex, thing_date: thing_date_regex }, defaults: { thing_type: "all", thing_sort: "new", thing_date: "all" }
    get "/u/:username/mod_queue(/:mod_queue_type)(/:thing_type)", to: "user_mod_queue#index", as: :user_mod_queue, constraints: { mod_queue_type: mod_queue_type_regex, thing_type: thing_type_regex }, defaults: { mod_queue_type: "all", thing_type: "all" }
    get "/u/:username/notifications", to: "user_notifications#index", as: :notifications
    get "/u/:username/bookmarks(/:thing_type)", to: "user_bookmarks#index", as: :bookmarks, constraints: { thing_type: thing_type_regex }, defaults: { thing_type: "all" }
    get "/u/:username/votes(/:vote_type)(/:thing_type)", to: "user_votes#index", as: :votes, constraints: { vote_type: vote_type_regex, thing_type: thing_type_regex }, defaults: { vote_type: "all", thing_type: "all" }

    get "/communities", to: "subs#index", as: :subs
    get "/c/:sub(/:thing_sort)(/:thing_date)", to: "subs#show", as: :sub, constraints: { thing_sort: thing_sort_regex, thing_date: thing_date_regex }, defaults: { thing_sort: "hot", thing_date: "all" }
    get "/c/:sub/edit", to: "subs#edit", as: :sub_edit

    post "/c/:sub/edit", to: "subs#update", as: :sub_update

    get "/c/:sub/mod_queue(/:mod_queue_type)(/:thing_type)", to: "sub_mod_queue#index", as: :sub_mod_queue, constraints: { mod_queue_type: mod_queue_type_regex, thing_type: thing_type_regex }, defaults: { mod_queue_type: "all", thing_type: "all" }
    get "/c/:sub/logs", to: "sub_logs#index", as: :sub_logs

    post "/c/:sub/follow", to: "sub_follow#create", as: :sub_follow_create
    delete "c/:sub/follow", to: "sub_follow#destroy", as: :sub_follow_delete

    get "/c/:sub/moderators", to: "sub_moderators#index", as: :sub_moderators
    post "/c/:sub/moderators/search", to: "sub_moderators#search", as: :sub_moderators_search
    get "/c/:sub/moderators/new", to: "sub_moderators#new", as: :sub_moderator_new
    post "/c/:sub/moderators", to: "sub_moderators#create", as: :sub_moderator_create
    get "/c/:sub/moderators/:id/edit", to: "sub_moderators#edit", as: :sub_moderator_edit
    post "/c/:sub/moderators/:id", to: "sub_moderators#update", as: :sub_moderator_update
    get "/c/:sub/moderators/:id/delete/confirm", to: "sub_moderators#confirm", as: :sub_moderator_delete_confirm
    delete "/c/:sub/moderators/:id", to: "sub_moderators#destroy", as: :sub_moderator_delete

    get "/c/:sub/contributors", to: "sub_contributors#index", as: :sub_contributors
    post "/c/:sub/contributors/search", to: "sub_contributors#search", as: :sub_contributors_search
    get "/c/:sub/contributors/new", to: "sub_contributors#new", as: :sub_contributor_new
    post "/c/:sub/contributors", to: "sub_contributors#create", as: :sub_contributor_create
    get "/c/:sub/contributors/:id/delete/confirm", to: "sub_contributors#confirm", as: :sub_contributor_delete_confirm
    delete "/c/:sub/contributors/:id", to: "sub_contributors#destroy", as: :sub_contributor_delete

    get "/c/:sub/bans", to: "sub_bans#index", as: :sub_bans
    post "/c/:sub/bans/search", to: "sub_bans#search", as: :sub_bans_search
    get "/c/:sub/bans/new", to: "sub_bans#new", as: :sub_ban_new
    post "/c/:sub/bans", to: "sub_bans#create", as: :sub_ban_create
    get "/c/:sub/bans/:id/edit", to: "sub_bans#edit", as: :sub_ban_edit
    post "/c/:sub/bans/:id", to: "sub_bans#update", as: :sub_ban_update
    get "/c/:sub/bans/:id/delete/confirm", to: "sub_bans#confirm", as: :sub_ban_delete_confirm
    delete "/c/:sub/bans/:id", to: "sub_bans#destroy", as: :sub_ban_delete

    get "/c/:sub/rules", to: "sub_rules#index", as: :sub_rules
    get "/c/:sub/rules/new", to: "sub_rules#new", as: :sub_rule_new
    post "/c/:sub/rules", to: "sub_rules#create", as: :sub_rule_create
    get "/c/:sub/rules/:id/edit", to: "sub_rules#edit", as: :sub_rule_edit
    post "/c/:sub/rules/:id", to: "sub_rules#update", as: :sub_rule_update
    get "/c/:sub/rules/:id/delete/confirm", to: "sub_rules#confirm", as: :sub_rule_delete_confirm
    delete "/c/:sub/rules/:id", to: "sub_rules#destroy", as: :sub_rule_delete

    get "/c/:sub/deletion_reasons", to: "sub_deletion_reasons#index", as: :sub_deletion_reasons
    get "/c/:sub/deletion_reasons/new", to: "sub_deletion_reasons#new", as: :sub_deletion_reason_new
    post "/c/:sub/deletion_reasons", to: "sub_deletion_reasons#create", as: :sub_deletion_reason_create
    get "/c/:sub/deletion_reasons/:id/edit", to: "sub_deletion_reasons#edit", as: :sub_deletion_reason_edit
    post "/c/:sub/deletion_reasons/:id", to: "sub_deletion_reasons#update", as: :sub_deletion_reason_update
    get "/c/:sub/deletion_reasons/:id/delete/confirm", to: "sub_deletion_reasons#confirm", as: :sub_deletion_reason_delete_confirm
    delete "/c/:sub/deletion_reasons/:id", to: "sub_deletion_reasons#destroy", as: :sub_deletion_reason_delete

    get "/c/:sub/tags", to: "sub_tags#index", as: :sub_tags
    get "/c/:sub/tags/new", to: "sub_tags#new", as: :sub_tag_new
    post "/c/:sub/tags", to: "sub_tags#create", as: :sub_tag_create
    get "/c/:sub/tags/:id/edit", to: "sub_tags#edit", as: :sub_tag_edit
    post "/c/:sub/tags/:id", to: "sub_tags#update", as: :sub_tag_update
    get "/c/:sub/tags/:id/delete/confirm", to: "sub_tags#confirm", as: :sub_tag_delete_confirm
    delete "/c/:sub/tags/:id", to: "sub_tags#destroy", as: :sub_tag_delete

    get "/c/:sub/pages", to: "sub_pages#index", as: :sub_pages
    get "/c/:sub/pages/new", to: "sub_pages#new", as: :sub_page_new
    get "/c/:sub/pages/:id/edit", to: "sub_pages#edit", as: :sub_page_edit
    get "/c/:sub/pages/:id", to: "sub_pages#show", as: :sub_page
    post "/c/:sub/pages", to: "sub_pages#create", as: :sub_page_create
    post "/c/:sub/pages/:id", to: "sub_pages#update", as: :sub_page_update
    get "/c/:sub/pages/:id/delete/confirm", to: "sub_pages#confirm", as: :sub_page_delete_confirm
    delete "/c/:sub/pages/:id", to: "sub_pages#destroy", as: :sub_page_delete

    get "/c/:sub/blacklisted_domains", to: "sub_blacklisted_domains#index", as: :sub_blacklisted_domains
    post "/c/:sub/blacklisted_domains/search", to: "sub_blacklisted_domains#search", as: :sub_blacklisted_domains_search
    get "/c/:sub/blacklisted_domains/new", to: "sub_blacklisted_domains#new", as: :sub_blacklisted_domain_new
    post "/c/:sub/blacklisted_domains", to: "sub_blacklisted_domains#create", as: :sub_blacklisted_domain_create
    get "/c/:sub/blacklisted_domains/:id/delete/confirm", to: "sub_blacklisted_domains#confirm", as: :sub_blacklisted_domain_delete_confirm
    delete "/c/:sub/blacklisted_domains/:id", to: "sub_blacklisted_domains#destroy", as: :sub_blacklisted_domain_delete

    get "/post/new", to: "post#new", as: :post_new

    get "/c/:sub/text/new", to: "text_post#new", as: :text_post_new
    post "/c/:sub/text", to: "text_post#create", as: :text_post_create
    get "/c/:sub/:id/edit", to: "text_post#edit", as: :text_post_edit
    put "/c/:sub/:id", to: "text_post#update", as: :text_post_update

    get "/c/:sub/link/new", to: "link_post#new", as: :link_post_new
    post "/c/:sub/link", to: "link_post#create", as: :link_post_create

    get "/c/:sub/media/new", to: "media_post#new", as: :media_post_new
    post "/c/:sub/media", to: "media_post#create", as: :media_post_create

    get "/c/:sub/:id", to: "things#show", as: :thing
    post "/things_actions", to: "things_actions#index", as: :things_actions

    post "/c/:sub/:id/approve", to: "thing_approve#create", as: :thing_approve

    get "/c/:sub/:id/delete", to: "thing_delete#new", as: :thing_delete_new
    post "/c/:sub/:id/delete", to: "thing_delete#create", as: :thing_delete

    post "/c/:sub/:id/vote", to: "thing_vote#create", as: :thing_vote

    post "/c/:sub/:id/bookmark", to: "thing_bookmark#create", as: :thing_bookmark_create
    delete "/c/:sub/:id/bookmark", to: "thing_bookmark#destroy", as: :thing_bookmark_delete

    post "/c/:sub/:id/explicit", to: "thing_explicit#create", as: :thing_explicit_create
    delete "/c/:sub/:id/explicit", to: "thing_explicit#destroy", as: :thing_explicit_delete

    get "/c/:sub/:id/tag", to: "thing_tag#edit", as: :thing_tag_edit
    post "/c/:sub/:id/tag", to: "thing_tag#update", as: :thing_tag_update

    post "/c/:sub/:id/spoiler", to: "thing_spoiler#create", as: :thing_spoiler_create
    delete "/c/:sub/:id/spoiler", to: "thing_spoiler#destroy", as: :thing_spoiler_delete

    post "/c/:sub/:id/subscribe", to: "thing_notifications#create", as: :thing_notifications_create
    delete "/c/:sub/:id/subscribe", to: "thing_notifications#destroy", as: :thing_notifications_delete

    post "/c/:sub/:id/ignore_reports", to: "thing_ignore_reports#create", as: :thing_ignore_reports_create
    delete "/c/:sub/:id/ignore_reports", to: "thing_ignore_reports#destroy", as: :thing_ignore_reports_delete

    get "/c/:sub/:id/reports", to: "thing_reports#index", as: :thing_reports
    get "/c/:sub/:id/reports/new", to: "thing_reports#new", as: :thing_report_new
    post "/c/:sub/:id/reports", to: "thing_reports#create", as: :thing_report_create

    get "/c/:sub/:id/comments/new", to: "thing_comments#new", as: :thing_comment_new
    post "/c/:sub/:id/comments", to: "thing_comments#create", as: :thing_comment_create
    get "/c/:sub/:id/comments/edit", to: "thing_comments#edit", as: :thing_comment_edit
    put "/c/:sub/:id/comments", to: "thing_comments#update", as: :thing_comment_update

    get "/blacklisted_domains", to: "global_blacklisted_domains#index", as: :global_blacklisted_domains
    post "/blacklisted_domains/search", to: "global_blacklisted_domains#search", as: :global_blacklisted_domains_search
    get "/blacklisted_domains/new", to: "global_blacklisted_domains#new", as: :global_blacklisted_domain_new
    post "/blacklisted_domains", to: "global_blacklisted_domains#create", as: :global_blacklisted_domain_create
    get "/blacklisted_domains/:id/delete/confirm", to: "global_blacklisted_domains#confirm", as: :global_blacklisted_domain_delete_confirm
    delete "/blacklisted_domains/:id", to: "global_blacklisted_domains#destroy", as: :global_blacklisted_domain_delete

    get "/rules", to: "global_rules#index", as: :global_rules
    get "/rules/new", to: "global_rules#new", as: :global_rule_new
    post "/rules", to: "global_rules#create", as: :global_rule_create
    get "/rules/:id/edit", to: "global_rules#edit", as: :global_rule_edit
    post "/rules/:id", to: "global_rules#update", as: :global_rule_update
    get "/rules/:id/delete/confirm", to: "global_rules#confirm", as: :global_rule_delete_confirm
    delete "/rules/:id", to: "global_rules#destroy", as: :global_rule_delete

    get "/deletion_reasons", to: "global_deletion_reasons#index", as: :global_deletion_reasons
    get "/deletion_reasons/new", to: "global_deletion_reasons#new", as: :global_deletion_reason_new
    post "/deletion_reasons", to: "global_deletion_reasons#create", as: :global_deletion_reason_create
    get "/deletion_reasons/:id/edit", to: "global_deletion_reasons#edit", as: :global_deletion_reason_edit
    post "/deletion_reasons/:id", to: "global_deletion_reasons#update", as: :global_deletion_reason_update
    get "/deletion_reasons/:id/delete/confirm", to: "global_deletion_reasons#confirm", as: :global_deletion_reason_delete_confirm
    delete "/deletion_reasons/:id", to: "global_deletion_reasons#destroy", as: :global_deletion_reason_delete

    get "/pages", to: "global_pages#index", as: :global_pages
    get "/pages/new", to: "global_pages#new", as: :global_page_new
    get "/pages/:id/edit", to: "global_pages#edit", as: :global_page_edit
    get "/pages/:id", to: "global_pages#show", as: :global_page
    post "/pages", to: "global_pages#create", as: :global_page_create
    post "/pages/:id", to: "global_pages#update", as: :global_page_update
    get "/pages/:id/delete/confirm", to: "global_pages#confirm", as: :global_page_delete_confirm
    delete "/pages/:id", to: "global_pages#destroy", as: :global_page_delete

    get "/bans", to: "global_bans#index", as: :global_bans
    post "/bans/search", to: "global_bans#search", as: :global_bans_search
    get "/bans/new", to: "global_bans#new", as: :global_ban_new
    post "/bans", to: "global_bans#create", as: :global_ban_create
    get "/bans/:id/edit", to: "global_bans#edit", as: :global_ban_edit
    post "/bans/:id", to: "global_bans#update", as: :global_ban_update
    get "/bans/:id/delete/confirm", to: "global_bans#confirm", as: :global_ban_delete_confirm
    delete "/bans/:id", to: "global_bans#destroy", as: :global_ban_delete

    get "/logs", to: "global_logs#index", as: :global_logs
  end

  match "*path", via: :all, to: "page_not_found#show"
end