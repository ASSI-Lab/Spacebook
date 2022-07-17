class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.belongs_to :user

      t.string :name, null: false

      t.string :manager, null: false

      t.string :via, null: false
      t.string :civico, null: false
      t.string :cap, null: false
      t.string :citta, null: false
      t.string :provincia, null: false
      t.string :latitude
      t.string :longitude
      t.string :dep_map
      t.string :dep_event

      t.text :description
      t.integer :floors
      t.integer :number_of_spaces

      t.timestamps
    end

    add_index :departments, :name, unique: true, name: 'departments_index'
    add_index :departments, :manager, unique: true, name: 'department_manager_index'
    add_index :departments, [:via, :civico, :cap, :citta, :provincia], unique: true, name: 'department_position_index'

  end
end
