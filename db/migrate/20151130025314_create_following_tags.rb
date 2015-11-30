class CreateFollowingTags < ActiveRecord::Migration
  def change
    create_table :following_tags do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :following_tags, [ :tag_id, :user_id ], unique: true
  end
end
