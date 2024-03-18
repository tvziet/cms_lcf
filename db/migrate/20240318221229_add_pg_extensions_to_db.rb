class AddPgExtensionsToDb < ActiveRecord::Migration[5.2]
  def change
    enable_extension :pg_trgm
    enable_extension :unaccent

  end
end
