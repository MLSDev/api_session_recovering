class CreateApiSessionRecoveringRestorePasswordHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :api_session_recovering_restore_password_histories do |t|
      t.string     :remote_ip
      t.string     :token
      t.string     :email
      t.datetime   :expire_at
      t.datetime   :recovered_at
      t.references :user, foreign_key: true, index: { name: 'index_asr_restore_password_histories_on_user_id' }
      t.string     :frontend_path

      t.timestamps
    end

    add_index :api_session_recovering_restore_password_histories, :token, unique: true, name: 'index_asr_restore_password_histories_on_token'
    add_index :api_session_recovering_restore_password_histories, :expire_at, name: 'index_asr_restore_password_histories_on_expire_at'
    add_index :api_session_recovering_restore_password_attempts, 'LOWER(email)', name: 'index_asr_restore_password_histories_on_lower_email'
  end
end
