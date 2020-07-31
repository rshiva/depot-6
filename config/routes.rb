Rails.application.routes.draw do
  get "admin" => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
  resources :orders
  resources :line_items do
    post :increment, on: :member
    post :decrement,  on: :member
  end
  resources :carts
  root 'store#index', as: 'store_index' 
  resources :products do
    resources :comments, only: :create
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
