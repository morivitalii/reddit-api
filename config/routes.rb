Rails.application.routes.draw do
  root "home#index"

  namespace :api, constraints: ->(request) { request.format == :json } do
    resource :sign_up, only: [:create], controller: :sign_up
    resource :sign_in, only: [:create], controller: :sign_in
    resource :forgot_password, only: [:create], controller: :forgot_password
    resource :change_password, only: [:update], controller: :change_password
    resource :sign_out, only: [:destroy], controller: :sign_out
    resources :admins, only: [:index, :show, :create, :destroy]
    resources :exiles, only: [:index, :show, :create, :destroy]

    resource :users, only: [:update]

    resources :users, only: [:index, :show] do
      scope module: :users do
        namespace :communities do
          resources :bans, only: [:index]
          resources :follows, only: [:index]
          resources :moderators, only: [:index]
          resources :mutes, only: [:index]
        end

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
        resources :follows, only: [:index, :show]
        resource :follows, only: [:create, :destroy]
        resources :moderators, only: [:index, :show, :create, :destroy]
        resources :rules, only: [:index, :show, :create, :update, :destroy]
        resources :tags, only: [:index, :show, :create, :update, :destroy]
        resources :bans, only: [:index, :show, :create, :update, :destroy]
        resources :mutes, only: [:index, :show, :create, :update, :destroy]

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

        resources :posts, only: [:show, :create, :update] do
          scope module: :posts do
            resource :approve, only: [:update], controller: :approve
            resource :remove, only: [:update], controller: :remove
            resource :explicit, only: [:create, :destroy], controller: :explicit
            resource :spoiler, only: [:create, :destroy], controller: :spoiler
            resource :tag, only: [:update], controller: :tag
            resource :bookmarks, only: [:create, :destroy]
            resources :reports, only: [:index, :create]

            namespace :reports do
              resource :ignore, only: [:create, :destroy], controller: :ignore
            end

            namespace :votes do
              resource :ups, only: [:create, :destroy]
              resource :downs, only: [:create, :destroy]
            end

            resources :comments, only: [:show, :create, :update] do
              scope module: :comments do
                resource :approve, only: [:update], controller: :approve
                resource :remove, only: [:update], controller: :remove
                resource :bookmarks, only: [:create, :destroy]

                namespace :reports do
                  resource :ignore, only: [:create, :destroy], controller: :ignore
                end

                resources :reports, only: [:index, :show, :create, :destroy]

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
