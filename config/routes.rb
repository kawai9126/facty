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
  
  namespace :public do
    resources :items,only: [:index,:show]
  
  
    resources :end_users,only: [:show,:edit,:update] do
      member do
        get 'user_exit'
        patch 'update_exit'
      end
     end
    end


end



