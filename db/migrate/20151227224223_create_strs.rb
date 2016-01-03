class CreateStrs < ActiveRecord::Migration
  def change
    create_table :strs do |t|
      t.string :titleid
      t.string :text

      t.timestamps null: false
    end
    add_index :strs, :titleid
  end
end
