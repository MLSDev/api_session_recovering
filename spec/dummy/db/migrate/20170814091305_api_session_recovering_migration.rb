class ApiSessionRecoveringMigration < ActiveRecord::Migration[4.2]
  include ActiveRecord::Tasks

  def change
    puts 'Use migrations from gem instead!'

    return

    if defined?(::ActiveRecord::Migrator) && ::ActiveRecord::Migrator.respond_to?(:migrate)
      ::ActiveRecord::Migrator.migrate '../../../../db/migrate/'
    else
      DatabaseTasks.database_configuration = YAML.load_file(File.expand_path('../../../config/database.yml', __FILE__))[Rails.env]

      DatabaseTasks.migrations_paths = '../../../db/migrate/'

      DatabaseTasks.db_dir = '../../../db'

      DatabaseTasks.migrate
    end
  end
end
