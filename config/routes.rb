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

    resources :votes, only: [] do
      get :posts, action: :posts, on: :collection
      get :comments, action: :comments, on: :collection
    end

    resources :bookmarks, only: [] do
      get :posts, action: :posts, on: :collection
      get :comments, action: :comments, on: :collection
    end
  end

  resources :communities, only: [:show, :edit, :update] do
    resources :posts, only: [:new, :create]
    resource :follows, only: [:create, :destroy]
    resources :moderators, only: [:index, :new, :create, :destroy]
    resources :rules, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :bans, only: [:index, :new, :create, :edit, :update, :destroy]

    resources :mod_queues, only: [] do
      get :new_posts, action: :not_moderated_posts, on: :collection
      get :new_comments, action: :not_moderated_comments, on: :collection
      get :reported_posts, action: :reported_posts, on: :collection
      get :reported_comments, action: :reported_comments, on: :collection
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

  match "*path", via: :all, to: "page_not_found#show"
end