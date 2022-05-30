class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.belongs_to :space

      t.string :dep_name
      t.string :typology
      t.string :space_name
      t.integer :position
      t.datetime :start_date
      t.datetime :end_date
      
      t.string :state

      t.timestamps
    end

    add_index :seats, [:dep_name, :typology, :space_name, :position, :start_date, :end_date, :state], unique: true, name: 'seats_index'

  end
end
