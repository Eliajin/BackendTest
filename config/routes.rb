Rails.application.routes.draw do
  resources :nacebel, :request
  # Begin here
  root 'home#index'

  # Routes for request
  get 'request/new'
  post 'request/new', to: 'request#receive'
  get 'request/show'
  # Routes for Result
  get 'result/result'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
