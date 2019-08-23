Rails.application.routes.draw do
  resources :plants, only: [:show, :new, :create, :index] do
    resources :bookings, only: [:create]
  resources :plants do
    resources :bookings, only: [:create, :update, :edit, :show]
    resources :reviews, only: [ :new, :create ]
  end
  get "my_plants", to: 'plants#my_plants'
  resources :bookings, only: [:index]
  resources :reviews, only: [:destroy]
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
