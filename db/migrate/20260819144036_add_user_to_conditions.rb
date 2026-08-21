class AddUserToConditions < ActiveRecord::Migration[8.1]
  def up
    add_reference :conditions, :user, foreign_key: true, null: true

    # Backfill user_id from associated chat
    execute <<-SQL
      UPDATE conditions
      SET user_id = chats.user_id
      FROM chats
      WHERE chats.condition_id = conditions.id;
    SQL

    # Fallback if any condition had no chat
    first_user_id = select_value("SELECT id FROM users ORDER BY id ASC LIMIT 1")
    if first_user_id
      execute("UPDATE conditions SET user_id = #{first_user_id} WHERE user_id IS NULL;")
    end

    change_column_null :conditions, :user_id, false
  end

  def down
    remove_reference :conditions, :user, foreign_key: true
  end
end
