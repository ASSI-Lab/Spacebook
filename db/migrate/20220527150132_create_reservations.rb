class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :email
      t.string :department
      t.string :typology
      t.string :space
      t.integer :floor
      t.integer :seat
      t.datetime :start_date
      t.datetime :end_date
      t.string :state

      t.timestamps
    end

    add_index :reservations, [:email, :department, :typology, :space, :floor, :seat, :start_date, :end_date], unique: true, name: 'reservations_index'

  end
end
