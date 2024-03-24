class AddFullNameTrgmIndexToEmployees < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    reversible do |dir|
      dir.up   { execute("CREATE INDEX CONCURRENTLY employees_full_name_idx ON employees USING gin(full_name gin_trgm_ops)") }
      dir.down { execute("DROP INDEX employees_full_name_idx") }
    end
  end
end
