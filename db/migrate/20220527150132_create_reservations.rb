class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :user
      t.belongs_to :department
      t.belongs_to :space
      t.belongs_to :seat

      t.string :email, null: false
      t.string :dep_name, null: false
      t.string :typology, null: false
      t.string :space_name, null: false
      t.integer :floor
      t.integer :seat_num, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.string :state, null: false
      t.string :is_sync

      t.timestamps
    end

    add_index :reservations, [:email, :dep_name, :typology, :space_name, :seat_num, :start_date, :end_date], unique: true, name: 'reservations_index'

  end
end
