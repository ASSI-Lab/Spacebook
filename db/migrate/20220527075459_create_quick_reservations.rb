class CreateQuickReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :quick_reservations do |t|
      t.string :email
      t.string :department
      t.string :typology
      t.string :space

      t.timestamps
    end
    
    add_index :quick_reservations, :email, unique: true

  end
end
