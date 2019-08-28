Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dashboard
  resources :products
  resources :cart_items
  get 'sessions/new'
  get 'registrations/new'
  get 'registrations/index'
  get 'home/index'
  
  resources :cart_items, except:[:show] do 
    member do 
      patch 'cart_items/decrease_quantity'
      patch 'cart_items/increase_quantity'
    end
  end
  resources :addresses, except:[:update]  do 
    member do 
      patch 'addresses/default_address'
    end
  end
  resources :order_items do 
    collection do 
      get 'order_items/order_display'
    end
  end
  delete 'sessions/destroy' 
  
  post 'sessions/create'
  post 'registrations/create'

  root 'home#index'
end