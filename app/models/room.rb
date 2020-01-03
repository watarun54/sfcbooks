class Room < ApplicationRecord
  belongs_to :item
  has_many :messages, dependent: :destroy

  scope :rooms_of, -> (user_id) { where(host_user_id: user_id).or(where(guest_user_id: user_id)) }
end
