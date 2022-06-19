class Space < ApplicationRecord
    belongs_to :department, required: :true # Permette di inserire un riferimento delle tabelle alle quali è vincolata
    
    has_many :reservations, dependent: :destroy             #
    has_many :quick_reservations, dependent: :destroy       # Permette la distruzione a cascata di tutte le associazioini collegate
    has_many :favourite_spaces, dependent: :destroy         #
    has_many :seats, dependent: :destroy                    #

    accepts_nested_attributes_for :seats                # 
    accepts_nested_attributes_for :reservations         # Permette di aggiornare altre tabelle accedendovi tramite le associazioni
    accepts_nested_attributes_for :quick_reservations   #
    accepts_nested_attributes_for :favourite_spaces     #
end
