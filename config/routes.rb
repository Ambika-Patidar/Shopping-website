Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dashboard
  resources :products
  get 'sessions/new'
  get 'registrations/new'
  get 'home/index'

  delete 'sessions/destroy' 
  
  post 'sessions/create'
  post 'registrations/create'

  root 'home#index'
end
