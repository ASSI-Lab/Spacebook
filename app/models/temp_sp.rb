class TempSp < ApplicationRecord
    belongs_to :temp_dep, required: :true # Permette di inserire un riferimento delle tabelle alle quali è vincolata
    
end
