class Item < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :status, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: { only_integer: true, less_than: 100_000 }
  validates :lecture, length: { maximum: 50 }
  validates :teacher, length: { maximum: 50 }
  validates :memo, length: { maximum: 500 }
end
