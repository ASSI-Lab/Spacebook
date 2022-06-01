class Reservation < ApplicationRecord
    belongs_to :user, required: true        #
    belongs_to :department, required: true  # Permette di inserire un riferimento delle tabelle alle quali è vincolata
    belongs_to :space, required: true       #
    belongs_to :seat, required: true        #
end
