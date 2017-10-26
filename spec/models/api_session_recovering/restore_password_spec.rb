require 'rails_helper'

describe ApiSessionRecovering::RestorePassword do
  it { should be_a ApiSessionRecovering::ApplicationRecord }

  it { should belong_to :user }

  it { should callback(:setup_expire_at).before :create }

  describe '#setup_expire_at' do
    it { expect { subject.send :setup_expire_at }.to_not raise_error }
  end
end
