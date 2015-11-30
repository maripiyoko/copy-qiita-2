class FollowingTag < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag, class_name: ActsAsTaggableOn::Tag

  validates_presence_of :user_id, :tag_id
  validates_uniqueness_of :user_id, scope: :tag_id

  def items
    Item.tagged_with(self.tag.name)
  end
end
