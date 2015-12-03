Rails.application.routes.draw do

  namespace :api do
    get 'movies', to: 'movies#index'
  end

  resources :movies, only: [:index, :show]

  root to: 'visitors#index'
end
