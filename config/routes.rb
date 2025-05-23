Rails.application.routes.draw do
  resources :quotes
  resources :categories
  resources :sources
  resources :users
  root 'home#index'
  get '/about', to: 'about#index'
  get 'search', to: 'search#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/admin', to: 'home#aindex'
  get '/userhome', to: 'home#uindex'
  get '/your-quotes', to: 'home#uquotes'


end
