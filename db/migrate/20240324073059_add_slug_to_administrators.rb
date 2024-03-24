class AddSlugToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_column :administrators, :slug, :string
    add_index :administrators, :slug, unique: true
  end
end
