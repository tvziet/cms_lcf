class AddTitleTrgmIndexToDocuments < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    reversible do |dir|
      dir.up   { execute("CREATE INDEX CONCURRENTLY documents_title_idx ON documents USING gin(title gin_trgm_ops)") }
      dir.down { execute("DROP INDEX documents_title_idx") }
    end
  end
end
