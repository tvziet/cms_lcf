class AddNameTrgmIndexToDocumentLevels < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    reversible do |dir|
      dir.up   { execute("CREATE INDEX CONCURRENTLY document_levels_name_idx ON document_levels USING gin(name gin_trgm_ops)") }
      dir.down { execute("DROP INDEX document_levels_name_idx") }
    end
  end
end
