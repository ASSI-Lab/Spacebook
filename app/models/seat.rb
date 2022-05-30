class Seat < ApplicationRecord
    belongs_to :space, required: :true
    has_many :reservations, dependent: :destroy

end
