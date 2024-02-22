Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get "up" => "rails/health#show", as: :rails_health_check

  root 'profiles#index'

  resources :profiles, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch :toggle_list
    end
    resources :bookings, only: [:index, :new, :create, :show, :update] do
      member do
        patch :accept
        patch :reject
        patch :cancel
      end
    end
    get 'bookings/new', to: 'bookings#new', as: 'new_booking'
  end

  get 'profiles/:profile_id/bookings/:id/accept_form', to: 'bookings#accept_form', as: 'accept_booking_form'
  get 'profiles/:profile_id/bookings/:id/reject_form', to: 'bookings#reject_form', as: 'reject_booking_form'
  get 'profiles/:profile_id/bookings/:id/cancel_form', to: 'bookings#cancel_form', as: 'cancel_booking_form'

  # Your existing scope for user-specific routes remains unchanged
  scope '/user' do
    resources :bookings, only: [:index, :show, :edit, :update], as: 'user_bookings'
    get '/dashboard', to: 'dashboards#show', as: 'user_dashboard'
  end
end
