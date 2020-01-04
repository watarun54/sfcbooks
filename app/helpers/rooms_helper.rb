module RoomsHelper
  def host_or_guest?(room)
    return "Host" if room.host_user_id == current_user.id
    return "Guest" if room.guest_user_id == current_user.id
  end
end
