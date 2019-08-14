Rails.application.routes.draw do
  root "home#index"

  resource :sign_up, only: [:new, :create], controller: :sign_up
  resource :sign_in, only: [:new, :create], controller: :sign_in
  resource :forgot_password, only: [:new, :create], controller: :forgot_password
  resource :password, only: [:edit, :update], controller: :password
  resource :sign_out, only: [:destroy], controller: :sign_out
  resource :users, only: [:edit, :update]

  resources :users, only: [] do
    get :posts, action: :posts, on: :member
    get :comments, action: :comments, on: :member
  end

  resources :subs, only: [:show, :edit, :update] do
    resources :posts, only: [:new, :create]
    resource :follows, only: [:create, :destroy]
    resources :moderators, except: [:show, :edit, :update]
    resources :contributors, except: [:show, :edit, :update]
    resources :blacklisted_domains, except: [:show, :edit, :update]
    resources :rules, except: [:show]
    resources :pages
    resources :bans, except: [:show]

    resources :mod_queues, only: [] do
      get :posts, action: :posts, on: :collection
      get :comments, action: :comments, on: :collection
    end

    resources :reports, only: [] do
      get :posts, action: :posts, on: :collection
      get :comments, action: :comments, on: :collection
    end
  end

  resources :posts, only: [:show, :edit, :update, :destroy] do
    post :approve, action: :approve, on: :member
    get :remove, action: :remove, on: :member

    resource :comments, only: [:create]
    resource :votes, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]

    resources :reports, only: [:new, :create] do
      get "/", action: :show, on: :collection
    end
  end

  resources :comments, only: [:show, :edit, :update, :destroy] do
    post :approve, action: :approve, on: :member
    get :remove, action: :remove, on: :member
    resource :comments, only: [:new, :create]
    resource :votes, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]

    resources :reports, only: [:new, :create] do
      get "/", action: :show, on: :collection
    end
  end

  resources :bookmarks, only: [] do
    get :posts, action: :posts, on: :collection
    get :comments, action: :comments, on: :collection
  end

  resources :votes, only: [] do
    get :posts, action: :posts, on: :collection
    get :comments, action: :comments, on: :collection
  end

  match "*path", via: :all, to: "page_not_found#show"
end