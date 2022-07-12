Rails.application.routes.draw do

  resources :temp_deps
  resources :temp_week_days
  resources :temp_sps

  resources :departments
  resources :week_days
  resources :spaces
  resources :seats

  resources :reservations
  resources :quick_reservations
  resources :favourite_spaces

  resources :tasks

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }

  root "home#index"

  # Generali
  get "/home", to: "home#index"
  get "/personal_area", to: "personal_area#index"
  get "/informations", to: "informations#index"

  # Accessibili dall'area personale utente
  get "/user_reservations", to: "reservations#reserved"
  get "/favourite_spaces", to: "favourite_spaces#index"

  # Admin
  get "/management", to: "management#index"

  # Dipartimenti
  get "/make_department", to: "temp_deps#new"
  post '/make_department', to: 'temp_deps#set_temp_wd', as: 'set_temp_wd'
  get "/manager_department", to: "departments#manager_department"

  # Prenotazioni
  get "/make_reservation", to: "reservations#new"
  post '/make_reservation', to: 'reservations#set_department', as: 'set_department'
  post '/user_reservations', to: 'reservations#make_res', as: 'make_res'
  get "/make_quick_res", to: "quick_reservations#make_quick_res"

  get "/tasks", to:"tasks#index"
  post "/find_on_map", to:"home#find_on_map"

  resources :users do       # CONTROLLA LE MAIL DI CONFERMA E IN CASO DI ASSENZA PER NUOVA REGISTRAZIONE NE INVIA UNA (CONTROLLARE application_mailer PER ULTERIORI DETTAGLI)
    member do
      get :confirm_email
    end
  end

  devise_scope :user do     # CONTROLLA IL TIMEOUT DELLA SESSIONE DELL'UTENTE 
    get   "/check_session_timeout"    => "session_timeout#check_session_timeout"
    get   "/session_timeout"          => "session_timeout#render_timeout"
  end
  
end