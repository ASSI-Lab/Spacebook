class Department < ApplicationRecord
    belongs_to :user, required: :true   # Permette di inserire un riferimento delle tabelle alle quali è vincolata
    
    has_many :reservations, dependent: :destroy             #
    has_many :quick_reservations, dependent: :destroy       #
    has_many :favourite_spaces, dependent: :destroy         # Permette la distruzione a cascata di tutte le associazioini collegate
    has_many :spaces, dependent: :destroy                   #
    has_many :seats, through: :spaces, dependent: :destroy  #

    accepts_nested_attributes_for :spaces               # 
    accepts_nested_attributes_for :seats                # 
    accepts_nested_attributes_for :reservations         # Permette di aggiornare altre tabelle accedendovi tramite le associazioni
    accepts_nested_attributes_for :quick_reservations   #
    accepts_nested_attributes_for :favourite_spaces     #
end
