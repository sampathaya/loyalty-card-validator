Rails.application.routes.draw do
  mount Api::Base, at: "/"

  resources :customers
  resources :cards, only: %i[index check]
  post 'cards/check'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "cards#index"
end
