Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  get "/home", to: "home#index"
  get "/personal_area", to: "personal_area#index"
  get "/make_reservation", to: "make_reservation#index"
  get "/my_reservations", to: "my_reservations#index"
  get "/favorites_spaces", to: "favorites_spaces#index"
  get "/informations", to: "informations#index"
  get "/management", to: "management#index"
  get "/department", to: "department#index"
  get "/make_department", to: "make_department#index"

end
