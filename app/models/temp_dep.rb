class TempDep < ApplicationRecord
    belongs_to :user, required: :true   # Permette di inserire un riferimento delle tabelle alle quali è vincolata

    has_many :temp_sps, dependent: :destroy         # Permette la distruzione a cascata di tutte le associazioini collegate

    accepts_nested_attributes_for :temp_sps         # Permette di aggiornare altre tabelle accedendovi tramite le associazioni
end
