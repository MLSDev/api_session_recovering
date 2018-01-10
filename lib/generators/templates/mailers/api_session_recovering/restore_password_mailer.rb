class ApiSessionRecovering::RestorePasswordMailer < ApplicationMailer

  def email restore_password
    @restore_password = restore_password

    @code = @restore_password.token

    mail to: @restore_password.user.email, subject: "Restore password"
  end
end
