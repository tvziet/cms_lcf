class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.integer :status, default: 0
      t.datetime :published_at
      t.boolean :public, default: false
      t.integer :company_id
      t.text :group_ids, array: true, default: []

      t.timestamps
    end
  end
end
