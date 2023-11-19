Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :lodges, only: [:new, :create, :show, :edit, :update] do
    get 'city_list', on: :collection
    get 'search', on: :collection
    
    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      resources :seasonal_prices, only: [:new, :create, :show, :edit, :update]
      resources :reservations, shallow: true, only: [:new, :create, :show] do
        get 'confirmate', on: :member
        post 'confirm', on: :member
      end
    end
  end 

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
