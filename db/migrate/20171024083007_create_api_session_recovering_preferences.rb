class CreateApiSessionRecoveringPreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :api_session_recovering_preferences do |t|
      t.integer :allowed_password_restore_attempts_per_day_count, default: 20
      t.integer :allowed_password_reset_per_day_count,            default: 20

      t.timestamps
    end
  end
end
