Rails.application.routes.draw do
  root to: "items#index"

  devise_for :users, controllers: {
    sessions:             "users/sessions",
    registrations:        "users/registrations",
    passwords:            "users/passwords",
    omniauth_callbacks:   "users/omniauth_callbacks" 
  }

  resources :items do
    collection do
      get :manage
      get :search
    end
  end

  resources :rooms
  resources :messages

  get '*path', controller: 'application', action: 'render_404'
end
