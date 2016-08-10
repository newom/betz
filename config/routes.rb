Rails.application.routes.draw do

  get 'sessions/new'

  get 'payment/execute'
  root  'bets#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  post 'create_user' => 'users#create'
  post 'create_bet' => 'bets#create'
  post 'accept_bet' => 'bets#accept'
  patch 'accept_bet' => 'bets#accept'
  #get 'payment/execute' => 'payment/execute'
  resources :users
  resources :users do
    member do
      get 'open'
      get 'pending'
      get 'groups'
    end
  end
  resources :bets do
    patch :update, on: :collection, as: :update
    member do
      get 'pay'
      get 'paid'
    end
  end
  resources :groups

end
