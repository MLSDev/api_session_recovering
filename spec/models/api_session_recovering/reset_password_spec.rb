require 'rails_helper'

describe ApiSessionRecovering::ResetPassword do
  it { should be_a ApiSessionRecovering::ApplicationRecord }

  it { should belong_to :user }

  it { should validate_presence_of :token }

  it { should have_many(:reset_password_validations).with_primary_key(:token).with_foreign_key(:token) }

  describe '#validate_reset_password_attempts_count from ApiSessionRecovering::ResetPasswordAttemptsValidations' do
    before { subject.email = 'test@example.com' }

    let(:preference) do
      stub_model ApiSessionRecovering::Preference,
        allowed_password_restore_attempts_per_day_count: 0,
        allowed_password_reset_per_day_count: 0,
        allowed_password_reset_validations_per_day_count: 0
    end

    before { expect(ApiSessionRecovering::Preference).to receive(:first_or_create!).and_return preference }

    before { subject.valid? }

    it { expect(subject.errors[:base]).to include(I18n.t('api_session_recovering.errors.reset_password.too_many_attempts')) }
  end
end
