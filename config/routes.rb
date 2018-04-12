Rails.application.routes.draw do

  resources :channels
  resources :create_channels
  root 'products#index'
  resources :products
  resources :productgroups
  # resources :carts
  resources :orders do
    member do
      get 'payment'
      get 'execute'
    end
  end
  resources :order_items, only: [:create, :update, :destroy]

  resources :histories, only: [:index, :show]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }

end
