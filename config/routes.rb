Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'posts#index'

  get '/register' => 'users#new', as: 'register'
  get '/logout' => 'sessions#destroy', as: 'logout'
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/pin' => 'sessions#pin', as: 'pin'
  post '/pin' => 'sessions#pin'

  resources :posts, except: :destroy do
    member do
      post :vote
    end

    resources :comments, only: :create do
      member do
        post :vote
      end
    end
  end

  resources :categories, only: %i[create new show]
  resources :users, only: %i[create edit show update]
end
