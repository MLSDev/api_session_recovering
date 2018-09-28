require 'rails_helper'

describe ApiSessionRecovering::RestorePassword do
  it { should be_a ApiSessionRecovering::ApplicationRecord }

  it { should belong_to :user }

  it { should validate_presence_of :email }

  it { should callback(:setup_expire_at).before :create }

  it { should callback(:send_token).after(:commit) }

  it { should callback(:create_restore_password_history).after(:commit) }

  describe '#setup_expire_at' do
    it do
      expect { subject.send :setup_expire_at }.to_not raise_error

      expect(subject.expire_at).to_not be_nil
    end
  end

  describe '#create_restore_password_history' do
    before { expect(subject).to receive(:restore_password_history_params).and_return :restore_password_history_params }

    before do
      expect(ApiSessionRecovering::RestorePasswordHistory).to receive(:create!).with(:restore_password_history_params)
    end

    it { expect { subject.send :create_restore_password_history }.to_not raise_error }
  end
end
