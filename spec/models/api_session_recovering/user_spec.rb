require 'rails_helper'

describe ApiSessionRecovering::User do
  it { should be_a ApiSessionRecovering::ApplicationRecord }

  describe '.table_name with default config' do
    it { expect(described_class.table_name).to eq ApiSessionRecovering.configuration.users_table_name }
  end
end
