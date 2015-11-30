class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :item, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :stocks, [ :user_id, :item_id ], unique: true
  end
end
