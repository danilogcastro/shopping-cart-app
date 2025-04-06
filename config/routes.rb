require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products
  get '/cart', to: 'carts#show'
  patch '/cart', to: 'carts#update'
  # optei por fazer essa rota ser um alias da outra
  # pois não vejo diferença de comportamento entre as duas
  patch '/cart/add_item', to: 'carts#update'
  delete 'cart/:product_id', to: 'carts#delete_item'
  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
