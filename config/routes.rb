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

  root "home#index"

  resource :sign_up, only: [:new, :create], controller: :sign_up
  resource :sign_in, only: [:new, :create], controller: :sign_in
  resource :forgot_password, only: [:new, :create], controller: :forgot_password
  resource :password, only: [:edit, :update], controller: :password
  resource :sign_out, only: [:destroy], controller: :sign_out

  resources :bookmarks, only: [:index]
  resources :votes, only: [:index]
  resources :notifications, only: [:index]
  resources :mod_queues, only: [:index]

  resource :users, only: [:edit, :update]

  resources :users, only: [], path: "/u" do
    get "(/:thing_type)(/:thing_sort)(/:thing_date)", action: :show, as: "", on: :member, constraints: { thing_type: thing_type_regex, thing_sort: thing_sort_regex, thing_date: thing_date_regex }, defaults: { thing_type: "all", thing_sort: "new", thing_date: "all" }
  end

  get "/post/new", to: "post#new", as: :post_new

  resources :moderators, except: [:show], concerns: [:searchable, :confirmable]
  resources :blacklisted_domains, except: [:show, :edit, :update], concerns: [:searchable, :confirmable]
  resources :rules, except: [:show], concerns: [:confirmable]
  resources :deletion_reasons, except: [:show], concerns: [:confirmable]
  resources :pages, concerns: [:confirmable]
  resources :bans, except: [:show], concerns: [:searchable, :confirmable]
  resources :logs, only: [:index]

  resources :subs, only: [:index, :show, :edit, :update], path: "/r" do
    resources :texts, only: [:new, :edit, :create, :update]
    resources :links, only: [:new, :create]
    resources :medias, only: [:new, :create]

    resources :contributors, except: [:show, :edit, :update], concerns: [:searchable, :confirmable], controller: :sub_contributors
    resources :tags, except: [:show], concerns: [:confirmable], controller: :sub_tags
    resource :follow, only: [:create, :destroy], controller: :sub_follow
  end

  resources :things, only: [:show], path: "/t" do
    post "/actions", action: :actions, on: :collection, as: :actions

    resource :approve_things, only: [:create], as: :approve, path: :approve
    resource :delete_things, only: [:new, :create], as: :delete, path: :delete
    resource :votes, only: [:create]
    resource :bookmarks, only: [:create, :destroy]
    resource :specify_things, only: [:create, :destroy], as: :specify, path: :specify
    resource :spoiler_things, only: [:create, :destroy], as: :spoiler, path: :spoiler
    resource :tag_things, only: [:edit, :update], as: :tag, path: :tag
    resources :report_things, only: [:index, :new, :create], as: :reports, path: :reports
    resource :thing_subscriptions, only: [:create, :destroy], as: :subscription, path: :subscription
    resource :ignore_thing_reports, only: [:create, :destroy], as: :ignore_reports, path: :ignore_reports
    resource :comments, only: [:new, :create, :edit, :update, :destroy], as: :comment, path: :comment
  end

  match "*path", via: :all, to: "page_not_found#show"
end