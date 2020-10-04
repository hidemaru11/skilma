Rails.application.routes.draw do
  get 'requests/index'
  get 'requests/new'
  get 'requests/show'
  get 'requests/edit'
  devise_for :users, controllers: {
    registrations: 'users/registrations', sessions: 'users/sessions' 
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end
  
  root 'home#index'
  resources :requests
end
