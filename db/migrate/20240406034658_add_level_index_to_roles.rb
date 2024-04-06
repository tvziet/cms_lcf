class AddLevelIndexToRoles < ActiveRecord::Migration[5.2]
  def change
    add_index :roles, :level, unique: true
  end
end
