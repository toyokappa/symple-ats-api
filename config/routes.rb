Rails.application.routes.draw do
  mount_devise_token_auth_for 'Recruiter', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'auth' do
    resource :recruiter, only: %i[show]
  end
  scope '/:organization_id' do
    resources :recruiters, only: %i[index]
    resources :recruiter_invitations, only: %i[index create]
    resources :positions, only: %i[index create update]
    resources :channels, only: %i[index create update]
    resources :recruitment_selections, only: %i[index]
    resources :analytics, only: %i[index]
  end
  resources :recruitment_histories, only: %i[update]
  resources :candidates, only: %i[create update] do
    resource :position, only: %i[update], module: :candidates
  end
end
