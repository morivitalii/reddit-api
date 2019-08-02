Rails.application.routes.draw do
  concern :searchable do
    post :search, on: :collection
  end

  concern :comments_index do
    get :comments, action: :comments, on: :collection
  end

  concern :approvable do
    post :approve, action: :approve, on: :member
  end

  concern :removable do
    get :remove, action: :remove, on: :member
  end

  root "home#index"

  resource :sign_up, only: [:new, :create], controller: :sign_up
  resource :sign_in, only: [:new, :create], controller: :sign_in
  resource :forgot_password, only: [:new, :create], controller: :forgot_password
  resource :password, only: [:edit, :update], controller: :password
  resource :sign_out, only: [:destroy], controller: :sign_out

  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy], concerns: [:approvable, :removable] do
    get :tag, action: :tag, on: :member

    resource :comments, only: [:create]
    resource :votes, only: [:create]
    resource :bookmarks, only: [:create, :destroy]

    resources :reports, only: [:new, :create] do
      get "/", action: :show, on: :collection
    end
  end

  resources :comments, only: [:show, :edit, :update, :destroy], concerns: [:approvable, :removable] do
    resource :comments, only: [:new, :create]
    resource :votes, only: [:create]
    resource :bookmarks, only: [:create, :destroy]

    resources :reports, only: [:new, :create] do
      get "/", action: :show, on: :collection
    end
  end

  resource :users, only: [:edit, :update]

  resources :users, only: [:show], path: "/u" do
    get :comments, action: :comments, on: :member
  end

  resources :bookmarks, only: [:index], concerns: [:comments_index]
  resources :votes, only: [:index], concerns: [:comments_index]
  resources :reports, only: [:index], concerns: [:comments_index]
  resources :mod_queues, only: [:index], concerns: [:comments_index]
  resources :moderators, except: [:show, :edit, :update], concerns: [:searchable]
  resources :contributors, except: [:show, :edit, :update], concerns: [:searchable]
  resources :blacklisted_domains, except: [:show, :edit, :update], concerns: [:searchable]
  resources :rules, except: [:show]
  resources :deletion_reasons, except: [:show]
  resources :tags, except: [:show]
  resources :pages
  resources :bans, except: [:show]

  resources :subs, only: [:show, :edit, :update], path: "/s" do
    resource :follows, only: [:create, :destroy]
  end

  match "*path", via: :all, to: "page_not_found#show"
end