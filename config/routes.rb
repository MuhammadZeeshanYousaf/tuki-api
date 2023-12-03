Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  scope 'api/v1' do
    get "up" => "rails/health#show", as: :rails_health_check
  end

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users,
                 path: '', # path prefix
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'signup'
                 },
                 controllers: {
                   sessions: 'api/v1/users/sessions',
                   registrations: 'api/v1/users/registrations'
                 }

      # @Todo - Remove the test route
      get 'members', to: 'members#show'

      # Other routes
      # get "info" => "user#info", as: :user_info
      resource :user, only: [:show, :update], controller: :user do
        put :password
      end

      scope :admin, controller: :admins do
        get :dashboard
      end

      scope :owner, controller: :owners do
        get :dashboard
      end

      resources :announcements
      resources :events, shallow: true do
        resources :tickets do
          resources :bookings do
            resources :validations
          end
        end
      end

      resources :communities, shallow: true do
        resources :apartments
        resources :quinchos
        resources :sport_courts
        resources :reservations
      end

      concern :eliminated do
        delete :eliminate, on: :member
      end
      resources :owners, except: :update, concerns: :eliminated
      # resources :owners, path: :co_owners, as: :co_owners, concerns: :eliminated
      resources :co_owners, except: [:update, :destroy], concerns: :eliminated
      resources :tenants, except: :update, concerns: :eliminated
      resources :guests, except: :update
      resources :working_guests, except: :update


    end
  end

end
