module ApiSessionRecovering
  module Generators
    class MailersGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates/mailers/', __FILE__)

      desc "Creates mailers in your mailers dir"

      def copy_mailers
        template 'application_mailer.rb', 'app/mailers/application_mailer.rb'
        template 'api_session_recovering/restore_password_mailer.rb', 'app/mailers/api_session_recovering/restore_password_mailer.rb'
      end

    end
  end
end
