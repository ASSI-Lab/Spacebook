Rails.application.routes.draw do

  resources :temp_deps
  resources :temp_sps
  resources :seats
  resources :spaces
  resources :quick_reservations
  resources :favourite_spaces
  resources :reservations
  resources :departments
  resources :tasks

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }
  
  root "departments#index"
  
  get "/home", to: "departments#index"
  get "/personal_area", to: "personal_area#index"
  
  get "/make_reservation", to: "reservations#new"
  
  get "/user_reservations", to: "reservations#reserved"
  get "/favourite_spaces", to: "favourite_spaces#index"
  
  get "/management", to: "management#index"
  get "/informations", to: "informations#index"
  
  get "/make_department", to: "departments#new"
  get "/make_space", to: "spaces#new"
  #get "/confirm_department_creation", to: "departments#confirm_department_creation"
  
  get "/manager_department", to: "departments#manager_department"
  get "/edit_department", to: "departments#edit"
  get "/tasks", to:"tasks#index"

  resources :users do       # CONTROLLA LE MAIL DI CONFERMA E IN CASO DI ASSENZA PER NUOVA REGISTRAZIONE NE INVIA UNA (CONTROLLARE application_mailer PER ULTERIORI DETTAGLI)
    member do
      get :confirm_email
    end
  end

end
