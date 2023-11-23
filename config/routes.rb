Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

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
                 },
                 defaults: { format: :json }

      # @Todo - Remove the test route
      get 'members', to: 'members#show'

      # Other routes
      resources :communities, shallow: true do
        resources :apartments do
          resources :owners
          resources :tenants
        end
      end

    end
  end

end
