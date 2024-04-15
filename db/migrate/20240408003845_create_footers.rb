class CreateFooters < ActiveRecord::Migration[5.2]
  def change
    create_table :footers do |t|
      t.string :logo
      t.string :company_info
      t.string :company_phone
      t.string :company_email
      t.string :company_address_info

      t.timestamps
    end
  end
end
