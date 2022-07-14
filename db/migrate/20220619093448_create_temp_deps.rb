class CreateTempDeps < ActiveRecord::Migration[6.1]
  def change
    create_table :temp_deps do |t|
      t.belongs_to :user
      
      t.string :name
      
      t.string :manager
      
      t.string :via
      t.string :civico
      t.string :cap
      t.string :citta
      t.string :provincia
      
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
