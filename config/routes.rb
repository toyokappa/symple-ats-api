Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: %i[index]
  resources :positions, only: %i[index create update]
  resources :media, only: %i[index create update]
  resources :recruitment_selections, only: %i[index]
end
