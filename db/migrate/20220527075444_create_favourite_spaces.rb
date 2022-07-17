class CreateFavouriteSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_spaces do |t|
      t.belongs_to :user
      t.belongs_to :department
      t.belongs_to :space

      t.string :email, null: false
      t.string :dep_name, null: false
      t.string :typology, null: false
      t.string :space_name, null: false

      t.timestamps
    end

    add_index :favourite_spaces, [:email, :dep_name, :typology, :space_name], unique: true, name: 'favourite_spaces_index'

  end
end
