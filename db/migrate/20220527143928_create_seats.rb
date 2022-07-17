class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.belongs_to :space

      t.string :dep_name, null: false
      t.string :typology, null: false
      t.string :space_name, null: false
      t.integer :position, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.string :state

      t.timestamps
    end

    add_index :seats, [:dep_name, :typology, :space_name, :position, :start_date, :end_date, :state], unique: true, name: 'seats_index'

  end
end
