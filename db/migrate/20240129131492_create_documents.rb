class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :body
      t.references :document_level, foreign_key: true
      t.integer :company_id, default: nil
      t.text :group_ids, array: true, default: []
      t.integer :group_id, default: nil
      t.text :employee_ids, array: true, default: []

      t.timestamps
    end
  end
end
