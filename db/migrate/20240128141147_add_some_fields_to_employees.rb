class AddSomeFieldsToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :company_id, :integer
    add_column :employees, :group_id, :integer
  end
end
