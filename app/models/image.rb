class Image < ApplicationRecord
  belongs_to :item

  mount_uploader :path, ImageUploader

  validates :path, presence: true
end
