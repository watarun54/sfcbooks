class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show]
  before_action :authenticate_user_for_rooms!, only: [:show]

  def index
    @rooms = Room.rooms_of(current_user.id)
  end

  def show
    @message = Message.new
    @messages = @room.messages
  end

  def create
    @room = Room.find_by(item_id: params[:item_id], guest_user_id: current_user.id)

    unless @room
      @item = Item.find(params[:item_id])
      @room = @item.rooms.create(host_user_id: @item.user.id, guest_user_id: current_user.id)
    end
    redirect_to @room
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def authenticate_user_for_rooms!
    @host_user = User.find(@room.host_user_id)
    @guest_user = User.find(@room.guest_user_id)
    redirect_to root_path, notice: "You can't enter the room." if current_user != @host_user && current_user != @guest_user
  end
end
