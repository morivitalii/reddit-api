Rails.application.routes.draw do
  thing_sort_regex = /hot|new|top|controversy/
  thing_date_regex = /day|week|month/
  thing_type_regex = /posts|comments/
  vote_type_regex = /ups|downs/
  mod_queue_type_regex = /new|reports/

  concern :searchable do
    post "search", on: :collection
  end

  concern :confirmable do
    get 'confirm', on: :member
  end

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

  get "/c/:sub/mod_queue(/:mod_queue_type)(/:thing_type)", to: "sub_mod_queue#index", as: :sub_mod_queue, constraints: { mod_queue_type: mod_queue_type_regex, thing_type: thing_type_regex }, defaults: { mod_queue_type: "all", thing_type: "all" }

  get "/post/new", to: "post#new", as: :post_new

  post "/things_actions", to: "things_actions#index", as: :things_actions

  post "/c/:sub/:id/subscribe", to: "thing_notifications#create", as: :thing_notifications_create
  delete "/c/:sub/:id/subscribe", to: "thing_notifications#destroy", as: :thing_notifications_delete

  post "/c/:sub/:id/ignore_reports", to: "thing_ignore_reports#create", as: :thing_ignore_reports_create
  delete "/c/:sub/:id/ignore_reports", to: "thing_ignore_reports#destroy", as: :thing_ignore_reports_delete

  get "/c/:sub/:id/comments/new", to: "thing_comments#new", as: :thing_comment_new
  post "/c/:sub/:id/comments", to: "thing_comments#create", as: :thing_comment_create
  get "/c/:sub/:id/comments/edit", to: "thing_comments#edit", as: :thing_comment_edit
  put "/c/:sub/:id/comments", to: "thing_comments#update", as: :thing_comment_update

  concern :blacklisted_domains do |options|
    resources :blacklisted_domains, { except: [:show, :edit, :update], concerns: [:searchable, :confirmable] }.merge(options)
  end

  concern :rules do |options|
    resources :rules, { except: [:show], concerns: [:confirmable] }.merge(options)
  end

  concern :deletion_reasons do |options|
    resources :deletion_reasons, { except: [:show], concerns: [:confirmable] }.merge(options)
  end

  concern :pages do |options|
    resources :pages, { concerns: [:confirmable] }.merge(options)
  end

  concern :bans do
    resources :bans, except: [:show], concerns: [:searchable, :confirmable]
  end

  concern :logs do
    resources :logs, only: [:index]
  end

  concerns :blacklisted_domains
  concerns :rules
  concerns :deletion_reasons
  concerns :pages
  concerns :bans
  concerns :logs

  resources :subs, only: [:index, :edit, :update], path: "/r" do
    get "(/:thing_sort)(/:thing_date)", action: :show, as: "", on: :member, constraints: { thing_sort: thing_sort_regex, thing_date: thing_date_regex }, defaults: { thing_sort: "hot", thing_date: "all" }

    resources :texts, only: [:new, :edit, :create, :update]
    resources :links, only: [:new, :create]
    resources :medias, only: [:new, :create]

    resources :things, only: [:show], path: "/" do
      resource :approve_things, only: [:create], as: :approve, path: :approve
      resource :delete_things, only: [:new, :create], as: :delete, path: :delete
      resource :vote_things, only: [:create], as: :vote, path: :vote
      resource :bookmark_things, only: [:create, :destroy], as: :bookmark, path: :bookmark
      resource :specify_things, only: [:create, :destroy], as: :specify, path: :specify
      resource :spoiler_things, only: [:create, :destroy], as: :spoiler, path: :spoiler
      resource :tag_things, only: [:edit, :update], as: :tag, path: :tag
      resources :report_things, only: [:index, :new, :create], as: :reports, path: :reports
    end

    concerns :blacklisted_domains, controller: :sub_blacklisted_domains
    concerns :rules, controller: :sub_rules
    concerns :deletion_reasons, controller: :sub_deletion_reasons
    concerns :pages, controller: :sub_pages
    concerns :bans, controller: :sub_bans
    concerns :logs, controller: :sub_logs

    resources :contributors, except: [:show, :edit, :update], concerns: [:searchable, :confirmable], controller: :sub_contributors
    resources :moderators, except: [:show], concerns: [:searchable, :confirmable], controller: :sub_moderators
    resources :tags, except: [:show], concerns: [:confirmable], controller: :sub_tags
    resource :follow, only: [:create, :destroy], controller: :sub_follow
  end

  match "*path", via: :all, to: "page_not_found#show"
end