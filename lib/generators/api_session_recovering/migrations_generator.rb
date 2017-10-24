module ApiSessionRecovering
  module Generators
    class MigrationsGenerator < Rails::Generators::Base

      source_root File.expand_path('../../../../db/migrate/', __FILE__)

      desc "Creates a ApiSessionRecovering initializer in your application's config/initializers dir"

      def copy_migration_file
        template '20171024083007_create_api_session_recovering_preferences.rb',                "db/migrate/#{ 1.seconds.from_now.to_s(:number) }_create_api_session_recovering_preferences.rb"

        template '20171024083008_create_api_session_recovering_reset_password_attempts.rb',    "db/migrate/#{ 2.seconds.from_now.to_s(:number) }_create_api_session_recovering_reset_password_attempts.rb"

        template '20171024083009_create_api_session_recovering_reset_passwords.rb',            "db/migrate/#{ 3.seconds.from_now.to_s(:number) }_create_api_session_recovering_reset_passwords.rb"

        template '20171024083010_create_api_session_recovering_restore_password_attempts.rb',  "db/migrate/#{ 4.seconds.from_now.to_s(:number) }_create_api_session_recovering_restore_password_attempts.rb"

        template '20171024083011_create_api_session_recovering_restore_password_histories.rb', "db/migrate/#{ 5.seconds.from_now.to_s(:number) }_create_api_session_recovering_restore_password_histories.rb"

        template '20171024083012_create_api_session_recovering_restore_passwords.rb',          "db/migrate/#{ 6.seconds.from_now.to_s(:number) }_create_api_session_recovering_restore_passwords.rb"
      end

    end
  end
end
