class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :stocks, dependent: :destroy
  has_many :stock_items, through: :stocks, source: :item

  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "follower_id", dependent: :destroy
  validates_presence_of :name

  def stock(item)
    stocks.create(item: item)
  end

  def unstock(item)
    stocks.find_by!(item: item).destroy
  end
  end
end
