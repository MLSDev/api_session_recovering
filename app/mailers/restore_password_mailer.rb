class RestorePasswordMailer < ::ApplicationMailer
  layout ApiSessionRecovering.configuration.mailer_layout if ApiSessionRecovering.configuration.mailer_layout

  def email email, token, frontend_path
    @email         = email
    @token         = token
    @frontend_path = frontend_path

    mail to: email, subject: 'Restore password'
  end
end
