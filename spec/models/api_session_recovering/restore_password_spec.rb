require 'rails_helper'

describe ApiSessionRecovering::RestorePassword do
  it { should be_a ApiSessionRecovering::ApplicationRecord }

  it { should belong_to :user }

  it { should validate_presence_of :frontend_path }

  it { should validate_presence_of :email }

  it { should callback(:setup_expire_at).before :create }

  it { should callback(:send_token).after(:commit).on(:create) }

  it { should callback(:create_restore_password_history).after(:commit).on(:destroy) }

  describe '#setup_expire_at' do
    it do
      expect { subject.send :setup_expire_at }.to_not raise_error

      expect(subject.expire_at).to_not be_nil
    end
  end

  describe '#create_restore_password_history' do
    before { expect(subject).to receive(:remote_ip).and_return :remote_ip }

    before { expect(subject).to receive(:token).and_return :token }

    before { expect(subject).to receive(:email).and_return :email }

    before { expect(subject).to receive(:expire_at).and_return :expire_at }

    before { expect(Time).to receive_message_chain(:zone, :now).and_return :time_now }

    before { expect(subject).to receive(:user).and_return :user }

    before { expect(subject).to receive(:frontend_path).and_return :frontend_path }

    before do
      expect(ApiSessionRecovering::RestorePasswordHistory).to receive(:create!).with(
        remote_ip: :remote_ip,
        token: :token,
        email: :email,
        expire_at: :expire_at,
        recovered_at: :time_now,
        user: :user,
        frontend_path: :frontend_path
      )
    end

    it { expect { subject.send :create_restore_password_history }.to_not raise_error }
  end
end
