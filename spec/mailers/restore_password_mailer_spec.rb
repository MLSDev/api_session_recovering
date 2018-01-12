require 'rails_helper'

describe ApiSessionRecovering::RestorePasswordMailer do
  let(:user) { ApiSessionRecovering::User.create!(email: "eded@gmail.com", password: "qwqwqw") }

  let(:restore_password) { ApiSessionRecovering::RestorePassword.create!(email: "eded@gmail.com", frontend_path: '/frontend', user: user) }

  subject { ApiSessionRecovering::RestorePasswordMailer.email restore_password  }

  its(:subject) { should eq 'Restore password' }
end
