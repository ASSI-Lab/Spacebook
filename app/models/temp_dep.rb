class TempDep < ApplicationRecord
    belongs_to :user, required: :true   # Permette di inserire un riferimento delle tabelle alle quali è vincolata

    has_many :temp_sps, dependent: :destroy         # Permette la distruzione a cascata di tutte le associazioini collegate
    has_many :temp_week_days, dependent: :destroy   #

    accepts_nested_attributes_for :temp_sps         # Permette di aggiornare altre tabelle accedendovi tramite le associazioni
    accepts_nested_attributes_for :temp_week_days   #
end
