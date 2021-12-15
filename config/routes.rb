Rails.application.routes.draw do
  mount_devise_token_auth_for 'Recruiter', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :recruiters, only: %i[index]
  resources :positions, only: %i[index create update]
  resources :media, only: %i[index create update]
  resources :recruitment_selections, only: %i[index]
  resources :candidates, only: %i[create update] do
    resource :position, only: %i[update], module: :candidates
  end
end
