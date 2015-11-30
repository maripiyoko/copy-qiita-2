class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :stocks, dependent: :destroy
  has_many :stock_items, through: :stocks, source: :item

  validates_presence_of :name

  def stock(item)
    self.stocks.build(item: item)
  end

  def unstock(item)
    self.stocks.find_by!(item: item).destroy
  end
end
