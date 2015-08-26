Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :streams do
    get '/playlist' => 'streams#playlist'
    get '/current_song' => 'streams#current_song'
  end
  root 'streams#index'

  get "/stream_subscription" => "streams#subscription"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
