class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :manager
      t.string :via
      t.string :civico
      t.string :cap
      t.string :citta
      t.string :provincia
      t.text :description
      t.integer :floors
      t.integer :spaces
      t.integer :slot
      t.time :apertura
      t.time :chiusura

      t.timestamps
    end
  end
end
