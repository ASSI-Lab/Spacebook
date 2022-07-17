class CreateSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :spaces do |t|
      t.belongs_to :department

      t.string :dep_name, null: false
      t.string :typology, null: false
      t.string :name, null: false

      t.text :description
      t.integer :floor
      t.integer :number_of_seats
      t.string :state, null: false

      t.timestamps
    end

    add_index :spaces, [:dep_name, :typology, :name], unique: true, name: 'spaces_index'

  end
end
