# Router
Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "products#index" #we tell Rails the root route should render the Products index action
  resources :products
end