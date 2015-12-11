Rails.application.routes.draw do

  resources :user_sessions

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  namespace :api do
    get 'movies', to: 'movies#index'
    put 'movies', to: 'movies#update'
  end

  resources :movies, only: [:index, :show, :edit]

  root to: 'visitors#index'
end
