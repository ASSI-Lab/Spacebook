class Department < ApplicationRecord
    belongs_to :user, required: :true
    
    has_many :reservations, dependent: :destroy
    has_many :quick_reservations, dependent: :destroy
    has_many :favourite_spaces, dependent: :destroy
    has_many :spaces, dependent: :destroy
    has_many :seats, through: :spaces, dependent: :destroy

    accepts_nested_attributes_for :spaces
    accepts_nested_attributes_for :seats
end
