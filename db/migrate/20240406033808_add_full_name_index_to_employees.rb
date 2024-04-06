class AddFullNameIndexToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_index :employees, :full_name, unique: true
  end
end
