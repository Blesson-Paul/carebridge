class ChangeCuredDefaultOnConditions < ActiveRecord::Migration[8.1]
  def change
    change_column_default :conditions, :cured, from: nil, to: false
  end
end
