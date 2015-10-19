Rails.application.routes.draw do

  get 'sessions/new'

  root  'bets#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  post 'create_user' => 'users#create'
  resources :users
  resources :bets

end
