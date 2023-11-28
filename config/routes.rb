Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'user/show'
    end
  end
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
      get "info" => "user#info", as: :user_info

      scope :admin, controller: :admins do
        get :dashboard
      end

      scope :owner, controller: :owners do
        get :dashboard
        get :co_owners
      end

      resources :invitations
      resources :announcements
      resources :events, shallow: true do
        resources :tickets do
          resources :bookings do
            resources :validations
          end
        end
      end

      resources :communities, shallow: true do
        resources :apartments do
          resources :tenants
        end
        resources :quinchos
        resources :sport_courts
        resources :reservations
      end

      resources :owners
      resources :owners, path: :co_owners, as: :co_owners
      resources :guests

    end
  end

end
