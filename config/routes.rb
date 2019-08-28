Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end  
end
