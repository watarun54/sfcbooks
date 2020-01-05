class Item < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :status, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: { only_integer: true, less_than: 100_000 }
  validates :lecture, length: { maximum: 50 }
  validates :teacher, length: { maximum: 50 }
  validates :memo, length: { maximum: 500 }

  scope :sorting_by, -> (status) { where(status: status) }

  def self.search(keywords)
    return Item.all if keywords.empty?
    item_ids = keywords.map { |keyword|
                Item.where([
                  'title LIKE ? OR lecture LIKE ? OR teacher LIKE ? OR memo LIKE ?',
                  "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
                ]).pluck(:id)
              }.flatten.uniq
    Item.where(id: item_ids)
  end

  def on_sale?
    self.status == ITEM_STATUS_SELL
  end
end
