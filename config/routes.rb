# Router
Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "products#index" # we tell Rails the root route should render the Products index action
  resources :products

  resources :products do # creates nested routes — meaning that subscribers belong to a product.
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ] # defines a single page where a user can visit to unsubscribe
end