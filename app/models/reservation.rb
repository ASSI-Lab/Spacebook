class Reservation < ApplicationRecord
    belongs_to :user, required: true
    belongs_to :department, required: true
    belongs_to :space, required: true
    belongs_to :seat, required: true
end
