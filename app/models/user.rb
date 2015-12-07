class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :drafts
  has_many :stocks, dependent: :destroy
  has_many :stock_items, through: :stocks, source: :item

  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id", dependent: :destroy
  has_many :follower, through: :passive_relationships

  has_many :following_tags, dependent: :destroy

  validates_presence_of :name

  def stock(item)
    stocks.create(item: item)
  end

  def unstock(item)
    stocks.find_by!(item: item).destroy
  end

  def follow_user(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow_user(other_user)
    active_relationships.find_by!(followed_id: other_user.id).destroy
  end

  def follow_tag(tag)
    following_tags.create(tag_id: tag.id)
  end

  def unfollow_tag(tag)
    following_tags.find_by!(tag_id: tag.id).destroy
  end

  include FindByName
end
