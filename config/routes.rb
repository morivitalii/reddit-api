Rails.application.routes.draw do
  concern :searchable do
    post "search", on: :collection
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
  resources :reports, only: [:index]
  resources :mod_queues, only: [:index]
  resources :moderators, except: [:show, :edit, :update], concerns: [:searchable]
  resources :contributors, except: [:show, :edit, :update], concerns: [:searchable]
  resources :blacklisted_domains, except: [:show, :edit, :update], concerns: [:searchable]
  resources :rules, except: [:show]
  resources :deletion_reasons, except: [:show]
  resources :tags, except: [:show]
  resources :pages
  resources :bans, except: [:show], concerns: [:searchable]
  resources :logs, only: [:index]

  resources :subs, only: [:show, :edit, :update], path: "/s" do
    resource :follows, only: [:create, :destroy]
  end

  resources :things, only: [:show, :edit, :update], path: "/t" do
    post "/actions", action: :actions, on: :collection, as: :actions

    resource :approve_things, only: [:create], as: :approve, path: :approve
    resource :delete_things, only: [:new, :create], as: :delete, path: :delete
    resource :votes, only: [:create]
    resource :bookmarks, only: [:create, :destroy]

    resources :reports, only: [:new, :create] do
      get "/", action: :thing_index, on: :collection
    end

    resource :comments, only: [:new, :create, :edit, :update, :destroy], as: :comment, path: :comment
  end

  match "*path", via: :all, to: "page_not_found#show"
end