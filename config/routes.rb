Rails.application.routes.draw do
  resources :plants, only: [:show, :new, :create, :index] do
    collection do
      get "my_plants", to: 'plants#my_plants'
    end
  end
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
