Rails.application.routes.draw do

  root 'welcome#index'

  # get 'sessions/create'
  get 'auth/twitter',                                   as: :login
  get 'auth/twitter/callback', to: 'sessions#create'
  get 'logout',                to: 'sessions#destroy', as: :logout

  resources :users,     only: [:show]
  resources :favorites, only: [:update]
  resources :tweets,    only: [:create]
end
