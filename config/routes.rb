Rails.application.routes.draw do
  namespace 'auth' do
    resource :recruiter, only: %i[show]
  end
  get '/omniauth/google_oauth2/callback', to: 'auth/google_oauth2_callbacks#create'
  scope '/:organization_id' do
    resources :recruiters, only: %i[index]
    resources :recruiter_invitations, only: %i[index create]
    resources :organization_recruiters, only: %i[create]
    resources :positions, only: %i[index create update]
    resources :channels, only: %i[index create update]
    resources :recruitment_selections, only: %i[index]
    resources :analytics, only: %i[index]
    get "/recruiter_invitations/:token", to: "recruiter_invitations#show"
  end
  resources :recruitment_histories, only: %i[update]
  resources :candidates, only: %i[create update] do
    resource :position, only: %i[update], module: :candidates
  end

  mount_devise_token_auth_for 'Recruiter', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
