class AddNameTrgmIndexToCompanies < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    reversible do |dir|
      dir.up   { execute("CREATE INDEX CONCURRENTLY companies_name_idx ON companies USING gin(name gin_trgm_ops)") }
      dir.down { execute("DROP INDEX companies_name_idx") }
    end

  end
end
