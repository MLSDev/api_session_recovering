module ApiSessionRecovering
  module Generators
    class ResetPassswordMailerViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates/mail_templates/api_session_recovering/', __FILE__)

      desc 'Creates a restore_password mail template in your views dir'

      def copy_reset_password_mailer_view
        copy_file 'restore_password_mailer/email.html.erb', 'app/views/api_session_recovering/restore_password_mailer/email.html.erb'
      end

    end
  end
end
