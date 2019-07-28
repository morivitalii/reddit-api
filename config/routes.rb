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

  resources :posts, only: [:new, :create, :edit, :update, :destroy] do
    get "/new_destroy", action: :new_destroy, on: :member, as: :new_destroy
    post "/approve", action: :approve, on: :member, as: :approve

    resource :comments, only: [:create]
    resource :votes, only: [:create]
    resource :bookmarks, only: [:create, :destroy]

    resources :reports, only: [:new, :create] do
      get "/", action: :thing_index, on: :collection
    end
  end

  resources :comments, only: [:edit, :update, :destroy] do
    get "/new_destroy", action: :new_destroy, on: :member, as: :new_destroy
    post "/approve", action: :approve, on: :member, as: :approve

    resource :comments, only: [:new, :create]
    resource :votes, only: [:create]
    resource :bookmarks, only: [:create, :destroy]

    resources :reports, only: [:new, :create] do
      get "/", action: :thing_index, on: :collection
    end
  end

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

  resources :subs, only: [:show, :edit, :update], path: "/s" do
    resource :follows, only: [:create, :destroy]
  end

  match "*path", via: :all, to: "page_not_found#show"
end