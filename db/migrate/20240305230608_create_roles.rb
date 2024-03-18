class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
