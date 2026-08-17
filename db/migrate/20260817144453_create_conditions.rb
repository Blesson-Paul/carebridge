class CreateConditions < ActiveRecord::Migration[8.1]
  def change
    create_table :conditions do |t|
      t.string :description
      t.string :symptoms
      t.date :diagnosed_on
      t.boolean :cured

      t.timestamps
    end
  end
end
