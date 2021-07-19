Rails.application.routes.draw do

devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

devise_for :end_users, controllers: {
  sessions:      'end_users/sessions',
  passwords:     'end_users/passwords',
  registrations: 'end_users/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  
#ユーザー側  
  namespace :public do
    resources :items,only: [:index,:show,:edit,:new,:create,:update]
    resources :end_users,only: [:show,:edit,:update] do
      member do
        get 'user_exit'
        patch 'update_exit'
      end
     end
     resources :orders,only: [:index,:create,:show,:new] do
     collection do
      get 'finish'
      post 'check'
     end
    end
   resources :shipping_addresses,only: [:index,:destroy,:update,:edit,:create]
    resources :cart_items,only: [:index,:destroy,:update,:create] do
     collection do
      delete 'destroy_all'
     end
   end
  end
  
# 管理側
  namespace :admin do
    resources :genres,only: [:index,:edit,:update,:create]
    resources :end_users,only: [:index,:edit,:show,:update]
    resources :items,only: [:index,:edit,:show,:create,:update,:new]
    resources :orders,only: [:index,:show,:update]
    resources :order_items,only: [:update]
    resources :adimin,only: [:index,:create,:destroy]
  end
end
