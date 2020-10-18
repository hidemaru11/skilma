Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', sessions: 'users/sessions' 
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end
  
  root 'home#index'
  resources :requests
  resources :jobs
  resources :skills do
    resources :plans
  end
  resources :users, only: [:show, :edit, :update]
end
