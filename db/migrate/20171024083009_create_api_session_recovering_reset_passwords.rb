class CreateApiSessionRecoveringResetPasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :api_session_recovering_reset_passwords do |t|
      t.string     :remote_ip
      t.string     :token
      t.string     :email
      t.datetime   :expire_at
      t.references :user, index: true, foreign_key: true
      t.string     :frontend_path
      t.boolean    :token_is_valid

      t.timestamps
    end

    add_index :api_session_recovering_reset_passwords, :token, unique: true
    add_index :api_session_recovering_reset_passwords, :expire_at
  end
end
