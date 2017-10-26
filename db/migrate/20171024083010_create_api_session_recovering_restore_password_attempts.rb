class CreateApiSessionRecoveringRestorePasswordAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :api_session_recovering_restore_password_attempts do |t|
      t.string     :remote_ip
      t.string     :email

      t.timestamps
    end

    add_index :api_session_recovering_restore_password_attempts, :remote_ip,     name: 'index_asr_restore_password_attempts_on_remote_ip'
    add_index :api_session_recovering_restore_password_attempts, :email,         name: 'index_asr_restore_password_attempts_on_name'
    add_index :api_session_recovering_restore_password_attempts, 'LOWER(email)', name: 'index_asr_restore_password_attempts_on_lower_email'
    add_index :api_session_recovering_restore_password_attempts, :created_at,    name: 'index_asr_restore_password_attempts_on_created_at'
  end
end
