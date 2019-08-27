Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dashboard
  resources :products
  resources :cart_items
  resources :addresses
  get 'sessions/new'
  get 'registrations/new'
  get 'home/index'
  
  resources :cart_items, except:[:show] do 
    member do 
      patch 'cart_items/decrease_quantity'
      patch 'cart_items/increase_quantity'
    end
  end
  resources :order_items do 
    member do 
      get 'order_items/order_display'
    end
  end
  delete 'sessions/destroy' 
  
  post 'sessions/create'
  post 'registrations/create'

  root 'home#index'
end