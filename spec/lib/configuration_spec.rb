require 'rails_helper'

describe ApiSessionRecovering::Configuration do
  its(:users_table_name) { should eq 'users' }

  its(:allowed_password_restore_attempts_per_day_count) { should be_nil }

  its(:hours_for_restore_password_token_to_be_expired) { should eq 8 }

  its(:allowed_password_reset_validations_per_day_count) { should be_nil }
end
