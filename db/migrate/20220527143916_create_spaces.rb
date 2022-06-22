class CreateSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :spaces do |t|
      t.belongs_to :department
      
      t.string :dep_name
      t.string :typology
      t.string :name

      t.text :description
      t.integer :floor
      t.integer :number_of_seats
      t.string :state

      t.timestamps
    end

    add_index :spaces, [:dep_name, :typology, :name], unique: true, name: 'spaces_index'

  end
end
