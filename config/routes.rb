Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :admins
  ActiveAdmin.routes(self)

  resources :orders, only: [:new]

  post 'add_to_cart' => "carts#add_to_cart", as: "add_to_cart"
  get 'cart' => "carts#cart", as: "cart"

  root "products#index"
end
