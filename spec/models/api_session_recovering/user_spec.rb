require 'rails_helper'

describe ApiSessionRecovering::User do
  it { should be_a ApiSessionRecovering::ApplicationRecord }

  it { should have_secure_password }

  it { should have_many :restore_passwords }

  it { should have_many(:restore_password_attempts).with_foreign_key :email }

  describe '.table_name with default config' do
    it { expect(described_class.table_name).to eq ApiSessionRecovering.configuration.users_table_name }
  end
end
