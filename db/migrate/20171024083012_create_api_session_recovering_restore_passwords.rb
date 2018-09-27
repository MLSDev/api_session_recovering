class CreateApiSessionRecoveringRestorePasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :api_session_recovering_restore_passwords do |t|
      t.string     :remote_ip
      t.string     :token
      t.string     :email
      t.string     :phone
      t.integer    :status
      t.integer    :kind
      t.datetime   :expire_at
      t.references :user, index: true, foreign_key: true
      t.string     :frontend_path

      t.timestamps
    end

    add_index :api_session_recovering_restore_passwords, :token, unique: true
    add_index :api_session_recovering_restore_passwords, :expire_at
    add_index :api_session_recovering_restore_passwords, :kind
    add_index :api_session_recovering_restore_passwords, :status
    add_index :api_session_recovering_restore_passwords, 'LOWER(email)'
  end
end
