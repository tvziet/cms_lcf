class CreateCarousels < ActiveRecord::Migration[5.2]
  def change
    create_table :carousels do |t|
      t.boolean :active, default: false
      t.string :image

      t.timestamps
    end
  end
end
