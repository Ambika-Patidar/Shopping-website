Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get   'sessions/new'
  get 'registrations/new'
  get  'dashboard/index'

  post 'sessions/create'
  post 'registrations/create'

  root 'sessions#new'
end
