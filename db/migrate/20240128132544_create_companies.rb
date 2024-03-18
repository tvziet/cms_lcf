class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.string :slug

      t.index :slug, unique: true

      t.timestamps
    end
  end
end
