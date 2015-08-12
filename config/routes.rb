Rails.application.routes.draw do
  devise_for :users
  resources :streams do
    get '/playlist' => 'streams#playlist'
    get '/current_song' => 'streams#current_song'
  end
  root 'streams#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
