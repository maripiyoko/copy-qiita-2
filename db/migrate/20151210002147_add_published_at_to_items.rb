class AddPublishedAtToItems < ActiveRecord::Migration
  def change
    add_column :items, :published_at, :datetime, null: true
  end
end
