class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
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
      t.integer :slot

      t.timestamps
    end

    add_index :departments, :name, unique: true, name: 'departments_index'
    add_index :departments, :manager, unique: true, name: 'department_manager_index'
    add_index :departments, [:via, :civico, :cap, :citta, :provincia], unique: true, name: 'department_position_index'

  end
end
