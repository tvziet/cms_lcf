class AddSlugToDocumentLevels < ActiveRecord::Migration[5.2]
  def change
    add_column :document_levels, :slug, :string
    add_index :document_levels, :slug, unique: true
  end
end
