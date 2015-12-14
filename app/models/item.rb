class Item < ActiveRecord::Base
  belongs_to :user
  has_many :stocks

  acts_as_taggable

  validates_presence_of :title, :user_id

  scope :recent, -> { order(updated_at: :desc) }
  scope :drafts, -> { where(published_at: nil) }
  scope :published, -> { where.not(published_at: nil) }

  def publish
    self.published_at ||= Time.current
  end

end
