Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'posts#index'

  get '/register' => 'users#new', as: 'register'
  get '/logout' => 'sessions#destroy', as: 'logout'
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end

  resources :categories, only: %i[create new show]
  resources :users, only: %i[create edit show update]
end
