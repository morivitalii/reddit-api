Rails.application.routes.draw do
  root "home#index"

  namespace :api, constraints: ->(request) { request.format == :json } do
    resource :sign_up, only: [:create], controller: :sign_up
    resource :sign_in, only: [:create], controller: :sign_in
    resource :forgot_password, only: [:create], controller: :forgot_password
    resource :change_password, only: [:update], controller: :change_password
    resource :sign_out, only: [:destroy], controller: :sign_out
    resource :users, only: [:update]

    resources :users, only: [:show] do
      scope module: :users do
        namespace :posts do
          namespace :hot do
            resources :day, only: [:index]
            resources :week, only: [:index]
            resources :month, only: [:index]
            resources :all, only: [:index]
          end

          namespace :new do
            resources :day, only: [:index]
            resources :week, only: [:index]
            resources :month, only: [:index]
            resources :all, only: [:index]
          end

          namespace :top do
            resources :day, only: [:index]
            resources :week, only: [:index]
            resources :month, only: [:index]
            resources :all, only: [:index]
          end

          namespace :controversial do
            resources :day, only: [:index]
            resources :week, only: [:index]
            resources :month, only: [:index]
            resources :all, only: [:index]
          end
        end

        namespace :comments do
          namespace :hot do
            resources :day, only: [:index]
            resources :week, only: [:index]
            resources :month, only: [:index]
            resources :all, only: [:index]
          end

          namespace :new do
            resources :day, only: [:index]
            resources :week, only: [:index]
            resources :month, only: [:index]
            resources :all, only: [:index]
          end

          namespace :top do
            resources :day, only: [:index]
          end
        end

        resources :posts, only: [:index]
        resources :comments, only: [:index]

        namespace :bookmarks do
          resources :posts, only: [:index]
          resources :comments, only: [:index]
        end

        namespace :votes do
          resources :posts, only: [:index]
          resources :comments, only: [:index]

          namespace :ups do
            resources :posts, only: [:index]
            resources :comments, only: [:index]
          end

          namespace :downs do
            resources :posts, only: [:index]
            resources :comments, only: [:index]
          end
        end
      end
    end

    resources :communities, only: [:index, :show, :create, :update] do
      scope module: :communities do
        resource :follow, only: [:create, :destroy], controller: :follow
        resources :moderators, only: [:index, :new, :create, :destroy]
        resources :rules, only: [:index, :new, :create, :edit, :update, :destroy]
        resources :bans, only: [:index, :new, :create, :edit, :update, :destroy]

        namespace :mod_queues do
          namespace :new do
            resources :posts, only: [:index]
            resources :comments, only: [:index]
          end

          namespace :reports do
            resources :posts, only: [:index]
            resources :comments, only: [:index]
          end
        end

        resources :posts, only: [:index, :show, :create, :update] do
          scope module: :posts do
            resource :approve, only: [:update], controller: :approve
            resource :remove, only: [:edit, :update], controller: :remove
            resource :explicit, only: [:create, :destroy], controller: :explicit
            resource :spoiler, only: [:create, :destroy], controller: :spoiler
            resource :bookmarks, only: [:create, :destroy]
            resources :reports, only: [:index, :new, :create]

            namespace :reports do
              resource :ignore, only: [:create, :destroy], controller: :ignore
            end

            namespace :votes do
              resource :ups, only: [:create, :destroy]
              resource :downs, only: [:create, :destroy]
            end

            resources :comments, only: [:show, :create, :edit, :update] do
              scope module: :comments do
                resource :approve, only: [:update], controller: :approve
                resource :remove, only: [:edit, :update], controller: :remove
                resource :bookmarks, only: [:create, :destroy]
                resources :reports, only: [:index, :new, :create]

                namespace :reports do
                  resource :ignore, only: [:create, :destroy], controller: :ignore
                end

                namespace :votes do
                  resource :ups, only: [:create, :destroy]
                  resource :downs, only: [:create, :destroy]
                end
              end
            end
          end
        end
      end
    end
  end
end
