Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'gossips#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :gossips
  resources :users
  resources :cities
  resources :comments

  resources :gossips do
    resources :comments
  end

  get "/team", to: "static_pages#team"
  get "/contact", to: "static_pages#contact"
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

end
