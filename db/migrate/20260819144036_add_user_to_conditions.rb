class AddUserToConditions < ActiveRecord::Migration[8.1]
  def change
    add_reference :conditions, :user, null: false, foreign_key: true
  end
end
