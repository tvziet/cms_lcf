class AddTitleTrgmIndexToNews < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    reversible do |dir|
      dir.up   { execute("CREATE INDEX CONCURRENTLY news_title_idx ON news USING gin(title gin_trgm_ops)") }
      dir.down { execute("DROP INDEX news_title_idx") }
    end
  end
end
