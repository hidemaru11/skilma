Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', sessions: 'users/sessions' 
  }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
    post 'guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  root 'home#index'
  resources :mates
  resources :jobs
  resources :skills do
    resources :plans
  end
  resources :users, only: [:show, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:index, :create, :show]
  resources :notifications, only: :index
end
