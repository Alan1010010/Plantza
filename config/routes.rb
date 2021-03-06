Rails.application.routes.draw do
  resources :plants do
    resources :bookings, only: [:create, :show]
    resources :reviews, only: [ :new, :create ]
  end
  get "my_plants", to: 'plants#my_plants'
  resources :bookings, only: [:index, :destroy]
  resources :reviews, only: [:destroy]
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
