class CreateGroupEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :group_employees do |t|
      t.references :group, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end