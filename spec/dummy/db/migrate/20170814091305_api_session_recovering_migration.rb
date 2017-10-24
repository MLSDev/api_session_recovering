class ApiSessionRecoveringMigration < ActiveRecord::Migration[4.2]
  def change
    ::ActiveRecord::Migrator.migrate '../../../../db/migrate/'
  end
end
