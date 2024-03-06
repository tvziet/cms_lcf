class CreateDocumentLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :document_levels do |t|
      t.string :name
      t.integer :documents_count, default: 0

      t.timestamps
    end
  end
end
