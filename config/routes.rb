Rails.application.routes.draw do

  root 'welcome#index'

  get 'auth/twitter',                                   as: :login
  get 'auth/twitter/callback', to: 'sessions#create'
  get 'logout',                to: 'sessions#destroy', as: :logout

  resources :users,     only: [:show]
  resources :friends,   only: [:destroy]
  resources :favorites, only: [:create]
  resources :retweets,  only: [:create]
  resources :tweets,    only: [:create]
end
