class AddSlugToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :slug, :string
    add_index :news, :slug, unique: true
  end
end
