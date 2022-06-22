class CreateTempSps < ActiveRecord::Migration[6.1]
  def change
    create_table :temp_sps do |t|
      t.belongs_to :temp_dep
      
      t.string :dep_name
      t.string :typology
      t.string :name

      t.text :description
      t.integer :floor
      t.integer :number_of_seats
      t.string :state

      t.timestamps
    end

    add_index :temp_sps, [:dep_name, :typology, :name], unique: true, name: 'temp_sps_index'

  end
end
