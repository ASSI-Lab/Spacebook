class Seat < ApplicationRecord
    belongs_to :space, required: :true  # Permette di inserire un riferimento delle tabelle alle quali è vincolata

    has_many :reservations, dependent: :destroy # Permette la distruzione a cascata di tutte le associazioini collegate

    accepts_nested_attributes_for :reservations   # Permette di aggiornare altre tabelle accedendovi tramite le associazioni
end
