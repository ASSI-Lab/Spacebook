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
  end
end
