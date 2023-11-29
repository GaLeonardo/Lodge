Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'my_reservations', to: 'reservations#my_reservations'
  get 'lodge_reservations', to: 'lodges#lodge_reservations'
  get 'lodge_actives', to: 'lodges#lodge_actives'

  resources :lodges, only: [:new, :create, :show, :edit, :update] do
    get 'city_list', on: :collection
    get 'search', on: :collection
    
    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      resources :seasonal_prices, only: [:new, :create, :show, :edit, :update]
      resources :reservations, shallow: true, only: [:new, :create, :show] do
        get 'confirmate', on: :member
        post 'confirm', on: :member
        post 'cancel', on: :member
        post 'check_in', on: :member
        post 'check_out', on: :member

        resources :reviews, shallow: true, only: [:new, :create]
      end
    end
  end 
end
