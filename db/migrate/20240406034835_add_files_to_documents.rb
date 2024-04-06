class AddFilesToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :files, :json
  end
end
