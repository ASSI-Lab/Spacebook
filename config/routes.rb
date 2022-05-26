Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "home#index"

  get "/home", to: "home#index"
  get "/area_personale", to: "area_personale#index"

end
