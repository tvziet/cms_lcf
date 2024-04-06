class AddPhoneNumberToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :phone_number, :string, default: ''
    add_column :employees, :relative_phone_number, :string, default: ''
  end
end
