require 'rails_helper'

describe ApiSessionRecovering::RestorePasswordHistory do
  it { should be_a ApiSessionRecovering::ApplicationRecord }

  it { should belong_to :user }
end
