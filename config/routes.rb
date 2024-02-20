Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Define the root path
  root 'profiles#index'

  # Resourceful routes for Profiles
  resources :profiles, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch :toggle_list
    end
    resources :bookings, only: [:new, :create] do
      patch 'cancel', on: :member
    end
  end


  # User-specific routes for Bookings and a custom dashboard route
  scope '/user' do
    resources :bookings, only: [:index, :show, :edit, :update], as: 'user_bookings'
    get '/dashboard', to: 'dashboards#show', as: 'user_dashboard'
  end
end
