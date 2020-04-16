module MessagesHelper
  # current_user宛の未読メッセージがあるかどうか
  def has_unread_messages?
    room_ids = Room.rooms_of(current_user.id).pluck(:id)
    Message.where(room_id: room_ids, is_read: false).where.not(user_id: current_user.id).exists?
  end
end
