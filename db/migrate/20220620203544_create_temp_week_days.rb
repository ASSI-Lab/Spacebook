class CreateTempWeekDays < ActiveRecord::Migration[6.1]
  def change
    create_table :temp_week_days do |t|
      t.belongs_to :temp_dep

      t.string :dep_name
      t.string :day
      
      t.string :state
      t.datetime :apertura
      t.datetime :chiusura

      t.timestamps
    end

    add_index :temp_week_days, [:dep_name, :day], unique: true, name: 'temp_week_days_index'

  end
end
