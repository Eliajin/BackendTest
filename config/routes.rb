Rails.application.routes.draw do
  devise_for :users
  resources :nacebel, :request
  # Begin here
  root 'home#index'

  # Routes for request
  get 'request/new'
  post 'request/new', to: 'request#create'
  get 'request/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
