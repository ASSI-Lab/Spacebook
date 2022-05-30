class FavouriteSpace < ApplicationRecord
    belongs_to :user, required: :true
    belongs_to :department, required: :true
    belongs_to :space, required: :true
end
