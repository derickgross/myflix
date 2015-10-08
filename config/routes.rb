Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'pages#front'
  get '/', to: 'pages#front'
  get '/home', to: 'videos#index'
  get '/video(/:title)', to: 'videos#show'
  get '/register', to: 'users#new'
  resources :users, only: [:create]
  get '/sign_in', to: 'sessions#new'
  resources :sessions, only: [:create]
  get '/sign_out', to: 'sessions#destroy'
  get '/my_queue', to: 'queue_items#index'

  resources :queue_items, only: [:create, :destroy]
  resources :categories, only: [:index, :show]
  resources :videos, only: [:show] do
  	collection do
  		get :search, to: "videos#search"
  	end
    resources :reviews, only: [:create]
  end
end
