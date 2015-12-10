class RemoveDraftModel < ActiveRecord::Migration
  def change
    drop_table :drafts
  end
end
