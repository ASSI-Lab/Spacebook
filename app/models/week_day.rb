class WeekDay < ApplicationRecord
    belongs_to :department, required: :true # Permette di inserire un riferimento delle tabelle alle quali è vincolata
end
