class AddRoleReferenceToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_reference :administrators, :role, foreign_key: true
  end
end
