class CreateSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :spaces do |t|
      t.string :department
      t.string :typology
      t.string :space
      t.integer :floor
      t.integer :seats
      t.string :state

      t.timestamps
    end

    add_index :spaces, [:department, :typology, :space], unique: true, name: 'spaces_index'

  end
end
