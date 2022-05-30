class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :user
      t.belongs_to :department
      t.belongs_to :space
      t.belongs_to :seat

      t.string :email
      t.string :dep_name
      t.string :typology
      t.string :space_name
      t.integer :floor
      t.integer :seat_num
      t.datetime :start_date
      t.datetime :end_date
      
      t.string :state

      t.timestamps
    end

    add_index :reservations, [:email, :dep_name, :typology, :space_name, :floor, :seat_num, :start_date, :end_date], unique: true, name: 'reservations_index'

  end
end
