class ChangePublicToIsPublicForNews < ActiveRecord::Migration[5.2]
  def change
    rename_column :news, :public, :is_public
  end
end
