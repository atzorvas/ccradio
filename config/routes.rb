Rails.application.routes.draw do
  resources :streams do
    get '/playlist' => 'streams#playlist'
  end
  root 'streams#index'
end
