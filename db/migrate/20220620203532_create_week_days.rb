class CreateWeekDays < ActiveRecord::Migration[6.1]
  def change
    create_table :week_days do |t|
      t.belongs_to :department

      t.string :dep_name
      t.string :day
      
      t.string :state
      t.datetime :apertura
      t.datetime :chiusura

      t.timestamps
    end

    add_index :week_days, [:dep_name, :day], unique: true, name: 'week_days_index'

  end
end