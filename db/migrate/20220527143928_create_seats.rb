class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.string :department
      t.string :typology
      t.string :space
      t.integer :position
      t.datetime :start_date
      t.datetime :end_date
      t.string :state

      t.timestamps
    end

    add_index :seats, [:department, :typology, :space, :position, :start_date, :end_date, :state], unique: true, name: 'seats_index'

  end
end
