Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "homes/about"

  devise_for :customers, skip: [:confirmations, :omniauth_callbacks, :passwords, :unlocks], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:confirmations, :omniauth_callbacks, :passwords, :registrations, :unlocks], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :items, only: [:new, :create, :index, :show]
  end
end
