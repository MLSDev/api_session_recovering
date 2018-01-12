class ApiSessionRecovering::RestorePasswordMailer < ::ApplicationMailer

  layout ApiSessionRecovering.configuration.mailer_layout if ApiSessionRecovering.configuration.mailer_layout

  def email restore_password
    @restore_password = restore_password

    @frontend_path = @restore_password.frontend_path

    @code = @restore_password.token

    mail to: @restore_password.user.email, subject: "Restore password"
  end
end
