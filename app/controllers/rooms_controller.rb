class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :destroy]
  before_action :authenticate_user_for_rooms!, only: [:show, :destroy]

  def index
    @rooms = Room.rooms_of(current_user.id).order(created_at: :desc).page(params[:page]).per(TABLE_PER)
  end

  def show
    @message = Message.new
    @messages = @room.messages
  end

  def new
    @room = Room.find_by(item_id: params[:item_id], guest_user_id: current_user.id)
    return redirect_to @room if @room

    @item = Item.find(params[:item_id])
    @room = @item.rooms.new(host_user_id: @item.user.id, guest_user_id: current_user.id)

    authenticate_user_for_rooms!

    @message = Message.new
    @messages = @room.messages
    render :show
  end

  def destroy
    @room.destroy!
    respond_to do |format|
      format.html { redirect_to rooms_path, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
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
