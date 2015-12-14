Rails.application.routes.draw do

  resources :user_sessions

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  namespace :api do
    resources :movies, only: [:index, :update, :show]
  end

  resources :movies, only: [:index, :show, :edit]

  root to: 'visitors#index'
end
