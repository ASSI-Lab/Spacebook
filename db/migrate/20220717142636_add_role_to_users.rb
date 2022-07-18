class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :string
    add_column :users, :requested_manager, :string
  end
end
