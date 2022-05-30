class CreateFavouriteSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_spaces do |t|
      t.belongs_to :user
      t.belongs_to :department
      t.belongs_to :space
      
      t.string :email
      t.string :dep_name
      t.string :typology
      t.string :space_name

      t.timestamps
    end

    add_index :favourite_spaces, [:email, :dep_name, :typology, :space_name], unique: true, name: 'favourite_spaces_index'

  end
end
