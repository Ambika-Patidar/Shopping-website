Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dashboard
  resources :products
  resources :cart_items
  resources :addresses
  resources :order_items
  get 'sessions/new'
  get 'registrations/new'
  get 'home/index'
  
  resources :cart_items, :except => [:show] do 
    member do 
      patch 'cart_items/decrease_quantity'
      patch 'cart_items/increase_quantity'
    end
  end
  delete 'sessions/destroy' 
  
  post 'sessions/create'
  post 'registrations/create'

  root 'home#index'
end