class Item < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  validates_presence_of :title, :user_id
end
