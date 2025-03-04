require 'sidekiq/web'
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post '/auth/login', to: 'auth#login'
  post '/auth/logout', to: 'auth#logout'
  resources :users, only: [:create]
 
  resources :bets, only: [:create, :index]
  # get 'users/:id/bets', to: 'bets#user_bets'
  get 'betshistory', to: 'bets#bet_history'
  
  resources :games, only: [:index, :show, :update]

  resources :leaderboard, only: [:index]

  mount Sidekiq::Web => '/sidekiq'
end


