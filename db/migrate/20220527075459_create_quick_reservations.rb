class CreateQuickReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :quick_reservations do |t|
      t.belongs_to :user
      t.belongs_to :department
      t.belongs_to :space
      
      t.string :email
      
      t.string :dep_name
      t.string :typology
      t.string :space_name

      t.timestamps
    end
    
    add_index :quick_reservations, :email, unique: true, name: 'quick_reservations_index'

  end
end
