class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :title, null: false, default: ""
      t.text :content
      t.references :user, index: true, foreign_key: true, null: false
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
