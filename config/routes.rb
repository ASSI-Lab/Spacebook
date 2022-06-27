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

  # View senza modello, consultare le relative view e controller.
  get "/home", to: "home#index"
  get "/personal_area", to: "personal_area#index"
  get "/manager_department", to: "departments#manager_department"
  get "/management", to: "management#index"
  get "/informations", to: "informations#index"

  # Accessibili dall'area personale utente
  get "/user_reservations", to: "reservations#reserved"
  get "/favourite_spaces", to: "favourite_spaces#index"

  # View riguardanti solo il manager
  get "/make_department", to: "temp_deps#new"
  get "/edit_department", to: "departments#edit"

  # Pagina principale per prenotare
  get "/make_reservation", to: "reservations#new"

  get "/tasks", to:"tasks#index"

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
