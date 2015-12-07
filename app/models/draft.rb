class Draft < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  acts_as_taggable

  validates_presence_of :user_id, :title
  validate :check_item_user, if: Proc.new { self.item.present? }

  before_save :update_item, if: Proc.new { self.item.present? }

  scope :recent, -> { order(updated_at: :desc) }
  scope :unpublished, -> { where(item: nil) }
  scope :published, -> { where.not(item: nil) }


  def publish
    if self.item.nil?
      self.item = self.user.items.new(title: self.title, content: self.content)
      save!
    end
  end

  private
    def update_item
      self.item.save! if self.item.present?
    end

    def check_item_user
      errors.add(:item, 'User for draft and item should match.') unless user == item.user
    end

end
