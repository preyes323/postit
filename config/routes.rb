Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'posts#index'

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end

  resources :categories, only: %i[create new show]
end
