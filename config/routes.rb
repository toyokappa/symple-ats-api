Rails.application.routes.draw do
  namespace 'auth' do
    resource :recruiter, only: %i[show]
    post '/google/callback', to: 'google_oauth2_callbacks#create'
  end
  scope '/:organization_id' do
    resources :recruiters, only: %i[index]
    resources :recruiter_invitations, only: %i[index create]
    resources :organization_recruiters, only: %i[create]
    resources :positions, only: %i[index create update destroy]
    resources :channels, only: %i[index create update destroy]
    resources :recruitment_selections, only: %i[index]
    resources :analytics, only: %i[index]
    resources :applies, only: %i[show create], param: :token
    get "/recruiter_invitations/:token", to: "recruiter_invitations#show"
  end
  resources :recruitment_histories, only: %i[update] do
    resources :recruitment_evaluations, only: %i[create update destroy]
    resource :auto_scheduling_token, only: %i[create destroy]
  end
  resources :candidates, only: %i[create update destroy] do
    resource :position, only: %i[update], module: :candidates
    resources :resumes, only: %i[create destroy], module: :candidates
  end
  resources :schedules, only: %i[show update], param: :token

  mount_devise_token_auth_for 'Recruiter', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
