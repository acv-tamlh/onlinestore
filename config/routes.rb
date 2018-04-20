Rails.application.routes.draw do

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
  devise_for :users, controllers: { registrations: 'registrations',
                                    omniauth_callbacks: "users/omniauth_callbacks"}

end
