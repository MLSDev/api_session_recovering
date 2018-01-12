require 'rails_helper'

describe ApiSessionRecovering::RestorePasswordMailer do
  let(:user) { create :user }

  let(:restore_password) { create :restore_password, user: user }

  subject { ApiSessionRecovering::RestorePasswordMailer.email restore_password  }

  its(:subject) { should eq 'Restore password' }
end
