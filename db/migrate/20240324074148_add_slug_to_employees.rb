class AddSlugToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :slug, :string
    add_index :employees, :slug, unique: true
  end
end
