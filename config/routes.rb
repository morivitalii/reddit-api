Rails.application.routes.draw do
  concern :searchable do
    post "search", on: :collection
  end

  concern :confirmable do
    get "confirm", on: :member
  end

  root "home#index"

  resource :sign_up, only: [:new, :create], controller: :sign_up
  resource :sign_in, only: [:new, :create], controller: :sign_in
  resource :forgot_password, only: [:new, :create], controller: :forgot_password
  resource :password, only: [:edit, :update], controller: :password
  resource :sign_out, only: [:destroy], controller: :sign_out
  resources :posts, only: [:new, :create, :edit, :update]
  resource :users, only: [:edit, :update]
  resources :users, only: [:show], path: "/u"
  resources :bookmarks, only: [:index]
  resources :votes, only: [:index]
  resources :notifications, only: [:index]
  resources :mod_queues, only: [:index]
  resources :moderators, except: [:show], concerns: [:searchable, :confirmable]
  resources :contributors, except: [:show, :edit, :update], concerns: [:searchable, :confirmable]
  resources :blacklisted_domains, except: [:show, :edit, :update], concerns: [:searchable, :confirmable]
  resources :rules, except: [:show], concerns: [:confirmable]
  resources :deletion_reasons, except: [:show], concerns: [:confirmable]
  resources :tags, except: [:show], concerns: [:confirmable]
  resources :pages, concerns: [:confirmable]
  resources :bans, except: [:show], concerns: [:searchable, :confirmable]
  resources :logs, only: [:index]

  resources :subs, only: [:show, :edit, :update], path: "/s" do
    resource :follows, only: [:create, :destroy]
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