Rails.application.routes.draw do

   # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
   devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
     sessions: "admin/sessions"
   }
  
  
  scope module: :public do
    root to: 'homes#top'
    get 'about', to: "homes#about"

    resources :items, only: [:index, :show]

    get 'customers/my_page', to:"customers#show"
    get 'customers/infomation/edit', to:"customers#edit"
    patch 'customers/infomation', to:"customers#update"
    get 'customers/unsubscribe', to: "customers#unsubscribe"
    patch 'customers/withdraw', to: "customers#withdraw"

    delete 'cart_items/destroy_all', to: "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
     
    get 'orders/thanks', to: "orders#thanks"
    post 'orders/confirm', to: "orders#confirm"
    resources :orders, only: [:new, :create, :index, :show]

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get 'homes', to: "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:update]
    resources :orders_details, only: [:update]
  end
  
   
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end