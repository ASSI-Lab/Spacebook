class Space < ApplicationRecord
    belongs_to :department, required: :true
    has_many :reservations, dependent: :destroy
    has_many :quick_reservations, dependent: :destroy
    has_many :favourite_spaces, dependent: :destroy
    has_many :seats, dependent: :destroy

    accepts_nested_attributes_for :seats
end
