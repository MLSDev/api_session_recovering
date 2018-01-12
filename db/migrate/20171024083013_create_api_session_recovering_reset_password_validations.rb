class CreateApiSessionRecoveringResetPasswordValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :api_session_recovering_reset_password_validations do |t|
      t.string :remote_ip
      t.string :token
      t.string :email
      t.string :phone

      t.timestamps
    end

    add_index :api_session_recovering_reset_password_validations, :token, name: 'index_api_session_recovering_reset_validations_on_token'
    add_index :api_session_recovering_reset_password_validations, :remote_ip, name: 'index_api_session_recovering_reset_validations_on_remote_ip'
    add_index :api_session_recovering_reset_password_validations, 'LOWER(email)', name: 'index_api_session_recovering_reset_validations_on_LOWER_email'
  end
end
