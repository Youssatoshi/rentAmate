Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  Rails.application.routes.draw do
    # Define the root path
    root 'profiles#index'

    # Resourceful routes for Profiles
    resources :profiles do
      # Nested resourceful routes for Bookings related to a Profile
      resources :bookings, only: [:new, :create]
    end

    # User-specific routes for Bookings and a custom dashboard route
    scope '/user' do
      resources :bookings, only: [:index, :show, :edit, :update], as: 'user_bookings'
      get '/dashboard', to: 'profiles#show', as: 'user_dashboard'
    end
  end
end
