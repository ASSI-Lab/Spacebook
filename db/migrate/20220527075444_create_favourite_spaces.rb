class CreateFavouriteSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_spaces do |t|
      t.string :email
      t.string :department
      t.string :typology
      t.string :space

      t.timestamps
    end

    add_index :favourite_spaces, [:email, :department, :typology, :space], unique: true, name: 'favourite_spaces_index'

  end
end
