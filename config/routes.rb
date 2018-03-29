Rails.application.routes.draw do

  root 'products#index'
  resources :products, only: [:index, :show]
  resources :productgroups, only: [:index, :show]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
