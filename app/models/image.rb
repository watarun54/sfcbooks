class Image < ApplicationRecord
  belongs_to :item

  mount_uploader :path, ImageUploader
end
