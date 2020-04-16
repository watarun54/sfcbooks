class Room < ApplicationRecord
  belongs_to :item
  has_many :messages, dependent: :delete_all

  scope :rooms_of, -> (user_id) { where(host_user_id: user_id).or(where(guest_user_id: user_id)) }

  def contain_unread_messages?(user)
    self.messages.where(is_read: false).where.not(user_id: user.id).exists?
  end
end
