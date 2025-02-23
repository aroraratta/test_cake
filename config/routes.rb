Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 汎用ルート
  root to: "homes#top"
  get "homes/about"

# 顧客用ルート
  devise_for :customers, skip: [:confirmations, :omniauth_callbacks, :passwords, :unlocks], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :public do
    resources :items, only: [:index, :show]
  end


# 管理者用ルート
  devise_for :admin, skip: [:confirmations, :omniauth_callbacks, :passwords, :registrations, :unlocks], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
end
