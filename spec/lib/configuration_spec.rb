require 'rails_helper'

describe ApiSessionRecovering::Configuration do
  its(:users_table_name) { should eq 'users' }

  its(:allowed_password_restore_attempts_per_day_count) { should be_nil }
end
