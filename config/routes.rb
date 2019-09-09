# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dashboard, only: :index
  resources :products
  resources :cart_items
  get 'sessions/new'
  get 'registrations/new'
  get 'registrations/index'
  get 'home/index'

  resources :cart_items, except: :show do
    member do
      patch :decrease_quantity
      patch :increase_quantity
    end
  end
  resources :addresses, except: :update do
    member do
      patch :set_address
    end
  end
  resources :order_items do
    collection do
      get :order_display
    end
  end
  delete 'sessions/destroy'

  post 'sessions/create'
  post 'registrations/create'

  root 'home#index'
end
