class ChangeRolesToRole < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :roles, :role
  end
end
