class User < ApplicationRecord
  
  # Permettono la rimozione a cascata dal db quando un utente viene eliminato
  has_many :departments, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :quick_reservations, dependent: :destroy
  has_many :favourite_spaces, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable, :recoverable, :rememberable, :validatable, :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]
         
  acts_as_user :roles => [ :manager, :admin, :user ]    #RUOLI DEFINITI PER IL CONTROLLO AUTORIZZAZIONI DI CANARD
  ROLES = %w[manager admin user].freeze               #RUOLI MOSTRATI NELLE CHECKBOX DI SIGNUP(MANTENERE LO STESSO ORDINE DI :roles !!!)
        

  def is?(role)                                                                        #***
    roles.include?(role.to_s)                                                          #
  end                                                                                  #

  def roles=(roles)                                                                    #
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)      # 
  end                                                                                  # FUNZIONI DI SUPPORTO PER DEFINIZIONE RUOLO DURANTE SIGNUP
  
  def roles                                                                            #
    ROLES.reject do |r|                                                                #
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?                               #
    end                                                                                #
  end                                                                                  #***

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(email: data['email'], password: Devise.friendly_token[0,20], confirmed_at: Time.zone.now ) 
    end
    user
  end

end
