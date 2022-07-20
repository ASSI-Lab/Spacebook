class CreateTempDeps < ActiveRecord::Migration[6.1]
  def change
    create_table :temp_deps do |t|
      t.belongs_to :user

      t.string :name, null: false

      t.string :manager, null: false

      t.string :via, null: false
      t.string :civico, null: false
      t.string :cap, null: false
      t.string :citta, null: false
      t.string :provincia, null: false
      t.string :lat
      t.string :lon

      t.text :description
      t.integer :floors
      t.integer :number_of_spaces
      t.string :dep_map
      t.string :dep_event

      t.timestamps
    end

    add_index :temp_deps, :name, unique: true, name: 'temp_deps_index'
    add_index :temp_deps, :manager, unique: true, name: 'temp_dep_manager_index'
    add_index :temp_deps, [:via, :civico, :cap, :citta, :provincia], unique: true, name: 'temp_dep_position_index'

  end
end
