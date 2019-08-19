Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/create'
  resources :plants, only: [:show, :new, :create, :index] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index]
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
